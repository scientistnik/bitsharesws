require "spec_helper"

RSpec.describe Bitshares do
  it "has a version number" do
    expect(Bitshares::VERSION).not_to be nil
  end
end
