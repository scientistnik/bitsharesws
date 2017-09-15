# Bitsharesws

This gem is websocket client for Decentralize Exchange BitShares. Now gem can get public information from Database API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bitsharesws'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bitsharesws

## Usage

`BitShares` is main class. Require it:

```ruby
require 'bitshares'
```

Becouse BitShares is decentralize exchange, before you use it, you need set node (for example openledger):

```ruby
BitShares.config do
	node 'wss://bitshares.openledger.info/ws'
end
```

This command try connect to this node. If you don't want connect now, use this:

```ruby
BitShares.config false do
	node 'wss://bitshares.openledger.info/ws'
end

# some else code

BitShares.start # now try to connect
```

If you want to set username and password:

```ruby
BitShares.config do
	node 'wss://bitshares.openledger.info/ws'
	login 'mylogin'
	pass 'mypass'
end
```

If you want to get account use `BitShares.account 'some-account-name'`.
If you want to know balance some account use `BitShares.balance 'some-account-name'`.

## Development

Now gem have only Database API. In future version, I want add all public and wallet API.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/scientistnik/bitsharesws.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
