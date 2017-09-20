require "spec_helper"

RSpec.describe BitShares do
  it "has a version number" do
    expect(BitShares::VERSION).not_to be nil
  end

	it "test" do
		BitShares.config do
			node "wss://node.testnet.bitshares.eu"
			login "bitsharesws1"
			pass "bitsharesws1"
		end

		p BitShares::RPC.new(1, "wallet",[]).send
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
