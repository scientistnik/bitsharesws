module BitShares
	class Wallet
		attr_accessor :amount, :asset
		def initialize hash
			@amount = hash['amount']
			@asset = BitShares::Asset[hash['asset_id']]
		end

		class << self
			def [] name, *ids
				RPC.new('get_named_account_balances',[name,ids]).send.inject([]) {|m,a| m << Wallet.new(a) }
			end
		end
	end
end
