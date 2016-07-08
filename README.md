# HIDE MY ASS! /2 [![Build Status](https://travis-ci.org/appPlant/hidemyass2.svg?branch=master)](https://travis-ci.org/appPlant/hidemyass2) [![Code Climate](https://codeclimate.com/github/appPlant/hidemyass2/badges/gpa.svg)](https://codeclimate.com/github/appPlant/hidemyass2) [![Test Coverage](https://codeclimate.com/github/appPlant/hidemyass2/badges/coverage.svg)](https://codeclimate.com/github/appPlant/hidemyass2/coverage) [![Dependency Status](https://gemnasium.com/badges/github.com/appPlant/hidemyass2.svg)](https://gemnasium.com/github.com/appPlant/hidemyass2)

Hide My Ass! /2 fetches proxies at www.hidemyass.com to allow everyone to surf privately from anywhere.

- Proxy lists are checked in real time

- Sortable by speed, with the fastest proxies listed first

- Sortable by country, anonymity, ...

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

To fetch all proxies simply run `HideMyAss.proxies`.

```ruby
require 'hidemyass'

proxies = HideMyAss.proxies
# => ProxyList
```

To reuse that list instead of fetching a new one use `HideMyAss.proxies!`.

To fetch proxies matching some criteria simply add filter options. Use `HideMyAss.form_data` to see and modify their defaults.

```ruby
require 'hidemyass'

# c[]  - Countries
# p    - Port. Defaults to all ports.
# pr[] - Protocol. 0..2 = HTTP, HTTPS, socks4/5
# a[]  - Anonymity level. 0..4 = None, Low, Medium, High, High +KA
# sp[] - Speed. 0..2 = Slow, Medium, Fast.
# ct[] - Connection time. 0..2 = Slow, Medium, Fast
# s    - Sort. 0..3 = Response time, Connection time, Country A-Z.
# o    - Order. 0, 1 = DESC, ASC.
# pp   - Per Page. 0..3 = 10, 25, 50, 100.
# sortBy - Sort by. Defaults to date.

proxies = HideMyAss.proxies 'c[]' => 'FRANCE', sortBy: 'response_time'

proxies.first.country
# => 'FRANCE'
```

Visit http://proxylist.hidemyass.com for more informations how to filter.

To get the url of each proxy call `proxy.url`.

```ruby
require 'hidemyass'

urls = HideMyAss.proxies.map(&:url)
# => ['https://178.22.148.122:3129',...]
```

Refer to the [Proxy](https://github.com/appPlant/hidemyass2/blob/master/lib/hidemyass/proxy.rb) class for more advanced usage and a complete list of properties like `speed`, `ip`, `ssl?`, `anonym?` or `secure?`.

Print out all proxy urls on command line:

    $ bundle exec hidemyass

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

