module BitShares
	class Rpc < Hash

		def initialize *args, name, params
			id, api_id = *args
			if api_id.nil?
				api_id = id
				id = 1
			end
			self[:method] = 'call'
			self[:id] = id
			self[:jsonrpc] = '2.0'
			self[:params] = [api_id || API.get_id_by_name(name), name, params]
		end

		def send
			WSocket.send self
		end

	end

	RPC = Rpc

end
