require 'hidemyass/proxy/base'

module HideMyAss
  module Proxy
    # Represent one proxy instance from https://hidester.com/proxylist
    class Hidester < Base
      # The IP of the proxy server.
      #
      # @return [ String ]
      def ip
        @row['IP']
      end

      # The port for the proxy.
      #
      # @return [ Int ]
      def port
        @row['PORT']
      end

      # The country where the proxy is hosted in downcase letters.
      #
      # @return [ String ]
      def country
        @row['country'].downcase
      end

      # The average response time in milliseconds.
      #
      # @return [ Int ]
      def speed
        @row['ping']
      end

      # The network protocol in in downcase letters.
      # (https or http or socks)
      #
      # @return [ String ]
      def type
        @row['type']
      end

      # The level of anonymity in downcase letters.
      # (low, medium, high, ...)
      #
      # @return [ String ]
      def anonymity
        case @row['anonymity']
        when 'Elite'     then 'high'
        when 'Anonymous' then 'medium'
        else 'no'
        end
      end

      # Time in minutes when its been last checked.
      #
      # @return [ Int ]
      def last_check
        require 'time'
        ((Time.now - Time.at(@row['latest_check'])) / 60).round
      end
    end
  end
end
