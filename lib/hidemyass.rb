require 'hidemyass/proxy_list'
require 'hidemyass/version'

# Hide My Ass! fetches proxies at www.hidemyass.com
#
# @example Ask for proxies multiple times
#          but retrieve the list just a single time.
#
#   HideMyAss.proxies
#   # => HideMyAss::ProxyList
#
# @example Fetch the list with each call.
#
#   HideMyAss.proxies!
#   # => HideMyAss::ProxyList
#
# @example Limit proxies to only available in Europe.
#
#   HideMyAss.proxies 'c[]' => 'Europe'
#   # => HideMyAss::ProxyList
#
module HideMyAss
  # List of proxies found at hidemyass.com.
  #
  # @example Fetch the list with each call.
  #   HideMyAss.proxies!
  #   # => HideMyAss::ProxyList
  #
  # @example Limit proxies to only available in Europe.
  #   HideMyAss.proxies 'c[]' => 'Europe'
  #   # => HideMyAss::ProxyList
  #
  # @param [ Hash ] data Optional form data for custom searches.
  #
  # @return [ HideMyAss::ProxyList> ]
  def self.proxies(data = nil)
    @proxies = nil
    proxies!(data)
  end

  # List of proxies found at hidemyass.com but returns former search result
  # if available.
  #
  # @example Fetch the list with each call.
  #   HideMyAss.proxies!
  #   # => HideMyAss::ProxyList
  #
  # @example Limit proxies to only available in Europe.
  #   HideMyAss.proxies 'c[]' => 'Europe'
  #   # => HideMyAss::ProxyList
  #
  # @param [ Hash ] data Optional form data for custom searches.
  #
  # @return [ HideMyAss::ProxyList> ]
  def self.proxies!(data = nil)
    self.form_data = data if data
    @proxies ||= ProxyList.new(form_data)
  end

  # Set form data to support custom searches.
  #
  # @param [ Hash ] data See form_data for more info.
  #
  # @return [ Void ]
  def self.form_data=(data)
    raise ArgumentError, 'form data has to be a hash' unless data.is_a? Hash
    @form_data = data
  end

  # Get form data for custom search.
  #
  # start     - Offset. Defaults to 0.
  # end       - Max. number of proxies to fetch. Defaults to 2000.
  # countries - Country. Defaults to all countries.
  # ports     - Port. Defaults to any port.
  # type      - Protocol. h = HTTP, s = HTTPS, 4 = SOCKS4, 5 = SOCKS5
  # anon      - Anonymity level. 1..4 = None, Low, Medium, High
  # maxtime   - Speed in milliseconds.
  #
  # @return [ Hash ]
  def self.form_data
    @form_data ||= { start: 0,
                     end:   2000,
                     anon:  nil,
                     type:  nil,
                     ports: nil,
                     maxtime: nil }
  end
end
