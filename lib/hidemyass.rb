require 'hidemyass/proxy_list'
require 'hidemyass/version'

# Hide My Ass! fetches proxies at www.hidemyass.com
#
# @example Ask for proxies multiple times
#          but retrieve the list just a single time.
#
#   HideMyAss.proxies
#   # => [HideMyAss::Proxy]
#
# @example Fetch the list with each call.
#
#   HideMyAss.proxies!
#   # => [HideMyAss::Proxy]
#
# @example Limit proxies to only available in Europe.
#
#   HideMyAss.proxies 'c[]' => 'Europe'
#   # => [HideMyAss::Proxy]
#
module HideMyAss
  # List of proxies found at hidemyass.com.
  #
  # @param [ Hash ] data Optional form data for custom searches.
  #
  # @return [ HideMyAss::ProxyList> ]
  def self.proxies!(*args)
    @proxies = nil
    proxies(*args)
  end

  # List of proxies found at hidemyass.com but does not clear cached proxies
  # from former search result.
  #
  # @param [ Hash ] data Optional form data for custom searches.
  #
  # @return [ HideMyAss::ProxyList> ]
  def self.proxies(data = nil)
    self.form_data = data if data
    @proxies ||= ProxyList.new(form_data)
  end

  # Set form data to support custom searches.
  #
  # @param [ Hash ] data See form_data for more info.
  #
  # @return [ Void ]
  def self.form_data=(data)
    @form_data = data
  end

  # Get form data for custom search.
  #
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
  #
  # @return [ Hash ]
  def self.form_data
    @form_data ||= { 'c[]'  => nil,
                     'p'    => nil,
                     'pr[]' => [0, 1],
                     'a[]'  => [3, 4],
                     'sp[]' => [1, 2, 3],
                     'ct[]' => [1, 2, 3],
                     's'    => 1,
                     'o'    => 0,
                     'pp'   => 3,
                     'sortBy' => 'response_time' }
  end
end
