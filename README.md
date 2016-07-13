# HIDE MY ASS! /2 [![Build Status](https://travis-ci.org/appPlant/hidemyass2.svg?branch=master)](https://travis-ci.org/appPlant/hidemyass2) [![Code Climate](https://codeclimate.com/github/appPlant/hidemyass2/badges/gpa.svg)](https://codeclimate.com/github/appPlant/hidemyass2) [![Test Coverage](https://codeclimate.com/github/appPlant/hidemyass2/badges/coverage.svg)](https://codeclimate.com/github/appPlant/hidemyass2/coverage) [![Dependency Status](https://gemnasium.com/badges/github.com/appPlant/hidemyass2.svg)](https://gemnasium.com/github.com/appPlant/hidemyass2)

Hide My Ass! /2 fetches lots of proxies to allow everyone to surf privately from anywhere.

- Around __3.200__ proxies

- Fetched in real time within __2.5 sec__

- Sortable by speed, country, anonymity and many more

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hidemyass2'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hidemyass2

## Usage

From terminal execute:

    $ bundle exec hidemyass

    https://188.166.233.171:8080
    http://187.85.207.47:3128
    http://201.22.213.7:8080
    https://103.253.146.197:8080
    https://139.59.226.223:8080
    socks4://80.255.139.145:1080
    socks5://5.135.151.28:60088
    ...

For Ruby run:

```ruby
require 'hidemyass'

HideMyAss.proxies { |p| p.country == 'germany' && p.https? }
#<HideMyAss::ProxyList:0x00000000000000 @proxies=[...]>

HideMyAss.proxies!.first
#<HideMyAss::Proxy:0x00000000000000 https://103.253.146.197:8080>
```

Refer to the [Proxy](https://github.com/appPlant/hidemyass2/blob/master/lib/hidemyass/proxy.rb) class for more advanced usage and a complete list of properties like `speed`, `ip`, `ssl?`, `anonym?` or `secure?`.

__Tip:__ Use `proxies!` to fetch the proxies just one time.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/appplant/hidemyass2.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Made with :yum: from Leipzig

© 2016 appPlant GmbH

