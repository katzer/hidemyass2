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

      # The level of anonymity.
      # (No=0, Anonymous=1, Elite=2)
      #
      # @return [ Int ]
      def anonymity
        case @row['anonymity']
        when 'Elite'     then 2
        when 'Anonymous' then 1
        else 0
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
