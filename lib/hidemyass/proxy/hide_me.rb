require 'hidemyass/proxy/base'

module HideMyAss
  module Proxy
    # Represent one proxy instance from http://hideme.ru/proxy-list
    class HideMe < Base
      # The IP of the proxy server.
      #
      # @return [ String ]
      def ip
        @ip ||= @row.at_xpath('td[1]/text()').text.strip
      end

      # The port for the proxy.
      #
      # @return [ Int ]
      def port
        @port ||= @row.at_xpath('td[2]/text()').text.strip.to_i
      end

      # The country where the proxy is hosted in downcase letters.
      #
      # @return [ String ]
      def country
        @country ||= @row.at_xpath('td[3]/div/text()')
                         .text.strip.downcase!.scan(/[[:word:]]+$/).last
      end

      # The average response time in milliseconds.
      #
      # @return [ Int ]
      def speed
        @speed ||= @row.at_xpath('td[4]/div/div/p/text()')
                       .text.scan(/^\d+/)[0].to_i
      end

      # The network protocol in in downcase letters.
      # (https or http or socks)
      #
      # @return [ String ]
      def type
        @type ||= @row.at_xpath('td[5]/text()').text.strip.split.last.downcase!
      end

      # The level of anonymity.
      # (low=0, medium=1, high=2)
      #
      # @return [ Int ]
      def anonymity
        @anonymity ||= begin
          case @row.at_xpath('td[6]/text()').text.strip
          when 'High'   then 2
          when 'Medium' then 1
          else 0
          end
        end
      end

      # Time in minutes when its been last checked.
      #
      # @return [ Int ]
      def last_check
        @last_check ||= @row.at_xpath('td[7]/text()').text.scan(/^\d+/)[0].to_i
      end
    end
  end
end
