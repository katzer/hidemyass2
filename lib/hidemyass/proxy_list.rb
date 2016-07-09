require 'forwardable'
require 'open-uri'
require 'net/http'
require 'nokogiri'
require 'hidemyass/proxy'

module HideMyAss
  # Represent a list of proxies that match the specified search properties.
  #
  # @example Iterate over all proxy server hosted in the US.
  #   ProxyList.new('c[]' => 'Europe').each { |proxy| ... }
  #
  # @example List of all proxy server URLs
  #   ProxyList.new.map(&:url)
  #   # => ['https://178.22.148.122:3129']
  class ProxyList
    include Enumerable
    extend Forwardable

    ENDPOINT = 'https://incloak.com/proxy-list/?start=0&end=2000'.freeze

    private_constant :ENDPOINT

    # Represent a list of proxies that match the specified search properties.
    #
    # @param [ Hash ] form_data See HideMyAss.form_data for more info.
    #
    # @return [ HideMyAss::ProxyList ]
    def initialize(form_data = HideMyAss.form_data)
      self.form_data = form_data.reject { |_, v| v.nil? }
      @proxies       = fetch
    end

    def_delegator :@proxies, :each

    # Form data to support custom searches
    #
    # @return [ Hash ]
    attr_accessor :form_data

    # Build URI for endpoint including all search form params.
    #
    # @return [ URI ]
    def uri
      uri       = URI(ENDPOINT)
      uri.query = URI.encode_www_form(form_data)
      uri
    end

    private

    # Fetch list of all proxies.
    #
    # @return [ Array<HideMyAss::Proxy> ]
    def fetch
      body  = Net::HTTP.get(uri)
      page  = Nokogiri::HTML(body, nil, 'UTF-8')
      sel   = '//*[@id="content-section"]/section[1]/div/table/tbody/tr'

      page.xpath(sel).map { |row| Proxy.new(row) }
    rescue Timeout::Error
      []
    end
  end
end
