require 'bitshares/version'

module BitShares
	autoload :WSocket,	'bitshares/wsocket'
	autoload :Wallet,		'bitshares/wallet'
	autoload :Asset,		'bitshares/asset'
	autoload :Account,	'bitshares/account'

	class << self

		attr_accessor :login, :pass

		def config autoconnect=true, &block
			@node = 'wss://node.testnet.bitshares.eu'
			@login = ''
			@pass = ''
			instance_eval(&block) if block_given?
			start if autoconnect
		end

		def node n=nil
			n ||= @node
			@node = n
		end

		def start
			WSocket.start
			WSocket.send id: 2, method: 'call', params: [1,'login',[@login,@pass]]
		end

		def stop() WSocket.stop end

		def database_id
			@database_id ||= WSocket.send(id: 2, method: 'call', params: [1,'database',[]])['result']
		end

		def account name
			answer = WSocket.send id: 2, method: "call", params: [database_id,"get_account_by_name",[name]]
			raise 'Bad request...' if answer.key? 'error'
			Account.new answer['result']
		end

		def balance name,*ids
			answer = WSocket.send id: 2, method: "call", params: [database_id,"get_named_account_balances",[name,ids]]
			raise 'Bad request...' if answer.key? 'error'
			answer['result'].inject([]) { |m,w| m << Wallet.new(w) } 
		end

		def assets *ids
			answer = WSocket.send id: 2, method: 'call', params: [database_id,'get_assets',[ids]]
			raise 'Bad request...' if answer.key? 'error'
			answer['result'].inject([]) {|m,a| m << Asset.new(a) }
		end

		def list_assets name, limit=10
			answer = WSocket.send id: 2, method: 'call', params: [database_id,'list_assets',[name,limit]]
			raise "Bad request...#{answer}" if answer.key? 'error'
			answer['result'].inject([]) {|m,a| m << Asset.new(a) }
		end

		def subscribe_callback id, clear_filter=true
			answer = WSocket.send id: 2, method: 'call', params: [database_id,'set_subscribe_callback',[id,clear_filter]]
			raise "Bad request...#{answer}" if answer.key? 'error'
			answer['result']
		end

	end
end
