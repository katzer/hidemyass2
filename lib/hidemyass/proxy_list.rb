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

    ENDPOINT = 'http://proxylist.hidemyass.com'.freeze

    private_constant :ENDPOINT

    # Represent a list of proxies that match the specified search properties.
    #
    # @param [ Hash ] form_data See HideMyAss.form_data for more info.
    #
    # @return [ HideMyAss::ProxyList ]
    def initialize(form_data)
      self.form_data = form_data
      @proxies       = fetch
    end

    attr_accessor :form_data

    def_delegator :@proxies, :each

    private

    # Fetch list of all proxies.
    #
    # @return [ Array<HideMyAss::Proxy> ]
    def fetch(url = ENDPOINT)
      res     = Net::HTTP.post_form(URI(url), form_data)
      page    = Nokogiri::HTML(res.body, nil, 'UTF-8')
      sel_row = '//table[@id="listable"]/tbody/tr'
      sel_lnk = 'section > section.section-component > section.hma-pagination li.arrow.next:not(.unavailable) > a' # rubocop:disable Metrics/LineLength

      proxies = page.xpath(sel_row).map { |row| Proxy.new(row) }
      link    = page.at_css(sel_lnk)

      link ? proxies.concat(fetch("#{ENDPOINT}#{link[:href]}")) : proxies
    end
  end
end
