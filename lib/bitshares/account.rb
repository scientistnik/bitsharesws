module BitShares
	class Account
		attr_reader :id, :name

		def initialize h
			@id = h['id'][/\d*$/]
			@name = h['name']
			@hash = h
		end

		def to_s() @name end
	end
end
