require 'websocket-eventmachine-client'
require 'json'

module BitShares
	module WSocket
		class << self

			def start
				@msgs = {}
				@thread ||= Thread.new { run }
				Thread.new do
					while @status != :disconnected do
						@thread[:ws].ping 'Hi' if @status == :connected
						sleep 50
					end
				end
				count = 0
				while @status != :connected and @status != :disconnected do
					sleep 0.1
					count += 1
					raise "TimeoutError..." if count > 100
				end
			end

			def thread() @thread end

			def stop
				EventMachine.stop
			end

			def send hash
				id = hash[:id]
				count = 0
				while @msgs[id] != nil do
					sleep 0.1
					count += 1
					raise "TimeoutError..." if count > 100
				end
				@thread[:ws].send hash.to_json if @status == :connected
				count = 0
				while @msgs[id].nil? and @status == :connected do
					sleep 0.1
					count += 1
					raise "TimeoutError..." if count > 100
				end

				result = @msgs[id]
				lock.synchronize do
					@msgs[id] = nil
				end
				result
			end

			def lock() @lock ||= Mutex.new end

			def get_notice
				if @msgs.key?('notice') && !@msgs['notice'].nil?
					msg = @msgs['notice']
					lock.synchronize do
						@msgs['notice'] = nil
					end
					msg
				else
					nil
				end
			end

			private
			def run
				begin
					@status ||= :start
					EM.run do
					 ws = WebSocket::EventMachine::Client.connect(:uri => BitShares.node)
					 Thread.current[:ws] = ws

						ws.onopen do
							if @status == :start
								puts "Connected"
								@status = :connected
							else
								EventMachine.stop
							end
						end

						ws.onmessage do |msg, type|
							json = JSON.parse msg
							id = json['id'] || json['method'] 
							lock.synchronize do
								@msgs[id] = json
							end
						end

						ws.onclose do |code, reason|
							puts "Disconnected with status code: #{code}"
							@status = :disconnected
							EventMachine.stop
						end

						ws.onpong do |msg|
							#puts "Pong #{msg}"
						end

					end
				rescue Exception => e
					puts e.message
				end

			end

		end
	end
end
