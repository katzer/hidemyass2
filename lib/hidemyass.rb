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
# @example Limit proxies to only available in Germany.
#
#   HideMyAss.proxies { country == 'Germany' }
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
  #   HideMyAss.proxies { country == 'Germany' }
  #   # => HideMyAss::ProxyList
  #
  # @param [ Proc ] block Optional where clause to filter out proxies.
  #
  # @return [ HideMyAss::ProxyList> ]
  def self.proxies(&block)
    @proxies = nil
    proxies!(&block)
  end

  # List of proxies found at hidemyass.com but returns former search result
  # if available.
  #
  # @example Fetch the list with each call.
  #   HideMyAss.proxies!
  #   # => HideMyAss::ProxyList
  #
  # @example Limit proxies to only available in Germany.
  #   HideMyAss.proxies { country == 'Germany' }
  #   # => HideMyAss::ProxyList
  #
  # @param [ Proc ] block Optional where clause to filter out proxies.
  #
  # @return [ HideMyAss::ProxyList> ]
  def self.proxies!(&block)
    @proxies ||= ProxyList.new(&block)
  end
end
