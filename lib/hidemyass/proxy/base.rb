
module HideMyAss
  module Proxy
    # Interface for the attributes of each proxy. Such attributes
    # include the ip, port and protocol.
    #
    # @example Get the proxy's ip address.
    #   proxy.ip
    #   # => '178.22.148.122'
    #
    # @example Get the proxy's port.
    #   proxy.port
    #   # => 3129
    #
    # @example Get the proxy's protocol.
    #   proxy.protocol
    #   # => 'HTTPS'
    #
    # @example Get the hosted country.
    #   proxy.country
    #   # => 'FRANCE'
    #
    # @example Get the complete url.
    #   proxy.url
    #   # => 'https://178.22.148.122:3129'
    class Base
      # Initializes the proxy instance by passing a single row of the fetched
      # result list. All attribute readers are lazy implemented.
      #
      # @param [ Object ] row Pre-parsed row element.
      #
      # @return [ HideMyAss::Proxy::Base ]
      def initialize(row)
        @row = row
      end

      # Raw data of the row element.
      #
      # @return [ Object ]
      attr_reader :row

      # The network protocol in in downcase letters.
      # (https or http or socks)
      #
      # @return [ String ]
      def protocol
        type
      end

      # The relative URL without the leading protocol.
      #
      # @return [ String ]
      def rel_url
        "#{ip}:#{port}"
      end

      # The complete URL of that proxy server.
      #
      # @return [ String ]
      def url
        "#{protocol}://#{rel_url}"
      end

      # If the proxy's network protocol is HTTP.
      #
      # @return [ Boolean ]
      def http?
        protocol == 'http'
      end

      # If the proxy's network protocol is HTTPS.
      #
      # @return [ Boolean ]
      def https?
        protocol == 'https'
      end

      # If the proxy's network protocol is SOCKS.
      #
      # @return [ Boolean ]
      def socks?
        protocol.start_with? 'socks'
      end

      # If the proxy supports SSL encryption.
      #
      # @return [ Boolean ]
      def ssl?
        https? || socks?
      end

      # If the proxy's anonymity is high or even higher.
      #
      # @return [ Boolean ]
      def anonym?
        anonymity.start_with? 'high'
      end

      # If the proxy's anonymity is at least high and protocol is encrypted.
      #
      # @return [ Boolean ]
      def secure?
        anonym? && ssl?
      end

      # Custom inspect method.
      #
      # @example
      #   inspect
      # => '<HideMyAss::Proxy http://123.57.52.171:80>'
      #
      # @return [ String ]
      # :nocov:
      def inspect
        "<#{self.class.name} #{url}>"
      end
      # :nocov:
    end
  end
end
