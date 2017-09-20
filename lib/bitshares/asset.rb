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
			def [] *ids
				id = ids.first
				if /^\d\.\d*\.\d*/.match(id)
					unless hash.key? id
						arr = RPC.new('get_assets',[[id]]).send.inject([]) {|m,a| m << Asset.new(a) }
					end
					(ids.size == 1) ? (hash[ida]) : (arr) 
				else
					arr = []
					hash.each_pair do |k,v|
						if ids.include? v.name
							(ids.size == 1) ? (return v) : (arr << v)
						end
					end
					arr
				end
			end

			def search name, limit=1
				Rpc.new('list_assets',[name,limit]).send.inject([]) {|m,a| m << Asset.new(a) }
			end

			def add h
				hash[h.id] = h unless hash.key? h.id
			end

			def hash() @h ||= {} end
		end
	end
end
