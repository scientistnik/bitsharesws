# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bitshares/version"

Gem::Specification.new do |spec|
  spec.name          = "bitsharesws"
  spec.version       = BitShares::VERSION
  spec.authors       = ["scientistnik"]
  spec.email         = ["nozdrin.plotnitsky@gmail.com"]

  spec.summary       = %q{WebSocket client for BitShares API}
  spec.description   = %q{WebSocket client for BitShares API}
  spec.homepage      = "https://github.com/scientistnik/bitsharesws.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

	spec.add_runtime_dependency 'json'
	spec.add_runtime_dependency 'websocket-eventmachine-client', '~> 1.2'

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
