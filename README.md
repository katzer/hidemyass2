# HIDE MY ASS! /2 [![Build Status](https://travis-ci.org/appPlant/hidemyass2.svg?branch=master)](https://travis-ci.org/appPlant/hidemyass2) [![Code Climate](https://codeclimate.com/github/appPlant/hidemyass2/badges/gpa.svg)](https://codeclimate.com/github/appPlant/hidemyass2) [![Test Coverage](https://codeclimate.com/github/appPlant/hidemyass2/badges/coverage.svg)](https://codeclimate.com/github/appPlant/hidemyass2/coverage) [![Dependency Status](https://gemnasium.com/badges/github.com/appPlant/hidemyass2.svg)](https://gemnasium.com/github.com/appPlant/hidemyass2)

Hide My Ass! /2 fetches proxies at https://incloak.com to allow everyone to surf privately from anywhere.

- Proxy lists are checked in real time

- Around __1.000__ proxies at all

- Sortable by speed, country, anonymity and many more

The graph shows the amount of change dynamics in the proxy list for the last 2 days.

<p align="left">
    <img src="https://incloak.com/images/last_2days_mini.png"></img>
</p>

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

HideMyAss.proxies
#<HideMyAss::ProxyList:0x00000000000000 @uri="..." @proxies=[...]>
```

__Note:__ To reuse that list instead of fetching a new one use `HideMyAss.proxies!`.

#### Filter proxies

```ruby
require 'hidemyass'

# start     - Offset. Defaults to 0.
# end       - Max. number of proxies to fetch. Defaults to 2000.
# countries - Country. Defaults to all countries.
# ports     - Port. Defaults to any port.
# type      - Protocol. h = HTTP, s = HTTPS, 4 = SOCKS4, 5 = SOCKS5
# anon      - Anonymity level. 1..4 = None, Low, Medium, High
# maxtime   - Speed in milliseconds.

proxies = HideMyAss.proxies countries: 'FR', type: 'hs'

proxies.first.country
# => 'france'
```

Visit https://incloak.com/proxy-list/ for more informations how to filter.

#### Get the url of each proxy

```ruby
require 'hidemyass'

urls = HideMyAss.proxies.map(&:url)
# => ['https://178.22.148.122:3129',...]
```

Refer to the [Proxy](https://github.com/appPlant/hidemyass2/blob/master/lib/hidemyass/proxy.rb) class for more advanced usage and a complete list of properties like `speed`, `ip`, `ssl?`, `anonym?` or `secure?`.

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

