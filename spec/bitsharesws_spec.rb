require "spec_helper"

RSpec.describe BitShares do
  it "has a version number" do
    expect(BitShares::VERSION).not_to be nil
  end

	it "test" do
		BitShares.config do
			node "wss://node.testnet.bitshares.eu"
		end
		dyn = BitShares::RPC.new("get_dynamic_global_properties",[]).send
		p dyn

		operation = [0,{amount: {amount: 10000, asset_id: "1.3.0"},
								 extensions: [],
								 fee: {amount: 21815, asset_id: "1.3.0"},
								 from: "1.2.124",
								 to: "1.2.1241"
								 }]
		hash = {}
		hash["expiration"] = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S")
		hash["extensions"] = []
		hash["ref_block_num"] = dyn["head_block_number"] & 0xFFFF
		hash["ref_block_prefix"] = [dyn["head_block_id"]].pack("H*")[4..-1].unpack("L<").first
		hash["signatures"] = ["adfafavgtsgtwhgrtcsvhs6tt"]
		hash["operations"] = [operation]

		p hash
		#p BitShares::WSocket.send hash
	end

	describe ".config" do
		it "set node" do
			BitShares.config false do
				node "my_node"
			end
			expect(BitShares.node).to eq("my_node")
		end

		it "set login" do
			BitShares.config false do
				login 'bitsharesws1'
			end

			expect(BitShares.login).to eq('bitsharesws1')
		end

		it "set pass" do
			BitShares.config false do
				pass "bitsharesws1"
			end

			expect(BitShares.pass).to eq("bitsharesws1")
		end
	end
end
