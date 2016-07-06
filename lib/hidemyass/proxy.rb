
module HideMyAss
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
  class Proxy
    # Initializes the proxy instance by passing a single row of the fetched
    # result list. All attribute readers are lazy implemented.
    #
    # @param [ Nokogiri::XML ] row Pre-parsed row element.
    #
    # @return [ HideMyAss::Proxy ]
    def initialize(row)
      @row = row
    end

    # Time in seconds when the last ping was made.
    #
    # @return [ Int ]
    def last_updated
      @last_updated ||= begin
        @row.at_xpath('td[1]').text.strip.split(' ').map do |it|
          case it
          when /sec/ then it.scan(/\d+/)[0].to_i
          when /min/ then it.scan(/\d+/)[0].to_i * 60
          when /h/   then it.scan(/\d+/)[0].to_i * 3_600
          when /d/   then it.scan(/\d+/)[0].to_i * 86_400
          end
        end.reduce(&:+)
      end
    end

    alias last_test last_updated

    # The IP of the proxy server.
    #
    # @return [ String ]
    def ip
      @ip ||= @row.at_xpath('td[2]/span').children
                  .select { |el| ip_block? el }
                  .map! { |el| el.text.strip }
                  .join('')
    end

    # The port for the proxy.
    #
    # @return [ Int ]
    def port
      @port ||= @row.at_xpath('td[3]').text.strip.to_i
    end

    # The country where the proxy is hosted.
    #
    # @return [ String ]
    def country
      @country ||= @row.at_xpath('td[4]').text.strip
    end

    # The average response time in milliseconds.
    #
    # @return [ Int ]
    def speed
      @speed ||= @row.at_xpath('td[5]/div')[:value].to_i
    end

    alias response_time speed

    # The average connection time in milliseconds.
    #
    # @return [ Int ]
    def connection_time
      @connection_time ||= @row.at_xpath('td[6]/div')[:value].to_i
    end

    # The network protocol in in downcase letters.
    # (https or http or socks4/5).
    #
    # @return [ String ]
    def type
      @type ||= @row.at_xpath('td[7]').text.strip.downcase
    end

    alias protocol type

    # The level of anonymity (Low, Medium, High, ...).
    #
    # @return [ String ]
    def anonymity
      @anonymity ||= @row.at_xpath('td[8]').text.strip
    end

    # The complete URL of that proxy server.
    #
    # @return [ String ]
    def url
      "#{protocol}://#{ip}:#{port}"
    end

    private

    # To find out if the element is a part of the IP.
    #
    # @param [ Nokogiri::XML ] el
    #
    # @return [ Boolean ]
    def ip_block?(el)
      return false if el[:style].to_s =~ /no/

      @clss ||= @row.at_xpath('td[2]/span/style').text.split
                    .map! { |it| it[1..4] if it !~ /none/ }.compact

      cls = el[:class].to_s

      el.name == 'text' || cls =~ /\d+/ || @clss.include?(cls)
    end
  end
end
