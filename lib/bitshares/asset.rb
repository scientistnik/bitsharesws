module BitShares
	class Asset
		attr_reader :id, :name

		def initialize hash
			@id = hash['id']
			@name = hash['symbol']
			@hash = hash
			self.class.add self
		end

		def to_s
			@name
		end

		class << self
			def [] id
				if /^\d\.\d*\.\d*/.match(id)
					BitShares.assets id unless hash.key? id
					hash[id] 
				else
					hash.each_pair do |k,v|
						return v if v.name == id
					end
				end
			end

			def add h
				hash[h.id] = h unless hash.key? h.id
			end

			def hash() @h ||= {} end
		end
	end
end
