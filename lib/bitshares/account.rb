module BitShares
	class Account
		attr_reader :id, :name

		def initialize h
			@id = h['id'][/\d*$/]
			@name = h['name']
			@hash = h
		end

		def to_s() @name end

		def balance *ids
			Wallet[@name,*ids]
		end

		class << self
			def [] name
				new RPC.new('get_account_by_name',[name]).send
			end
		end
	end
end
