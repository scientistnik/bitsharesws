require 'bitshares/version'

module BitShares
	autoload :WSocket,	'bitshares/wsocket'
	autoload :RPC,			'bitshares/rpc'
	autoload :API,			'bitshares/api'
	autoload :Wallet,		'bitshares/wallet'
	autoload :Asset,		'bitshares/asset'
	autoload :Account,	'bitshares/account'


	class << self

		def config autoconnect=true, &block
			@node = 'wss://node.testnet.bitshares.eu'
			@login = ''
			@pass = ''
			instance_eval(&block) if block_given?
			start if autoconnect
		end

		def node(n=nil)		n ||= @node; @node = n;		end
		def login(n=nil)	n ||= @login; @login = n; end
		def pass(n=nil)		n ||= @pass; @pass = n;		end

		def start
			WSocket.start
			RPC.new(1,'login',[@login,@pass]).send
		end

		def stop() WSocket.stop end

		def account name
			Account[name]
		end

		def balance name,*ids
			Wallet[name,*ids]
		end

		def assets *ids
			Asset[*ids]
		end

		def list_assets name, limit=1
			Asset.search name, limit
		end

		def subscribe_callback id, clear_filter=true
			RPC.new('set_subscribe_callback', [id, clear_filter]).send
		end

		def transfer what, amount, from, to
			RPC.new 'transfer',[]
		end

	end
end
