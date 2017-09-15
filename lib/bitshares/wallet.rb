module BitShares
	class Wallet
		attr_accessor :amount, :asset
		def initialize hash
			@amount = hash['amount']
			@asset = BitShares::Asset[hash['asset_id']]
		end
	end
end
