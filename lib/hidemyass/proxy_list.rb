require 'forwardable'
require 'open-uri'

module HideMyAss
  # Represent a list of proxies that match the specified search properties.
  #
  # @example Iterate over all proxy server hosted in the US.
  #   ProxyList.new { country == 'US'}.each { |proxy| ... }
  #
  # @example List of all proxy server URLs
  #   ProxyList.new.map(&:url)
  #   # => ['https://178.22.148.122:3129']
  class ProxyList
    include Enumerable
    extend Forwardable

    # Represent a list of proxies that match the specified search properties.
    #
    # @param [ Proc ] block Optional where clause to filter out proxies.
    #
    # @return [ HideMyAss::ProxyList ]
    def initialize(&block)
      @proxies = fetch(&block)
    end

    def_delegator :@proxies, :each

    private

    # Fetch proxies from all backends.
    #
    # @param [ Proc ] block Optional where clause to filter out proxies.
    #
    # @return [ Array<HideMyAss::Proxy::Base> ]
    def fetch(&block)
      proxies = hidester_proxies.concat(hide_me_proxies)
      proxies.uniq!(&:ip)

      block_given? ? proxies.keep_if(&block) : proxies
    end

    # Fetch all proxies from hideme.ru/proxy-list
    #
    # @return [ Array<HideMyAss::Proxy::HideMe> ]
    def hide_me_proxies
      require 'hidemyass/proxy/hide_me'
      require 'nokogiri'

      body  = open('https://incloak.com/proxy-list/?end=5000')
      page  = Nokogiri::HTML(body, nil, 'UTF-8')
      sel   = '//*[@id="content-section"]/section[1]/div/table/tbody/tr'

      page.xpath(sel).map { |row| Proxy::HideMe.new(row) }
    rescue Timeout::Error, LoadError, OpenURI::HTTPError
      []
    end

    # Fetch all proxies from hidester.com/proxylist
    #
    # @return [ Array<HideMyAss::Proxy::Hidester> ]
    def hidester_proxies
      require 'hidemyass/proxy/hidester'
      require 'json'

      body = open('https://hidester.com/proxydata/php/data.php?mykey=data&limit=5000&orderBy=latest_check&sortOrder=DESC')
      page = JSON.load(body)

      page.map { |row| Proxy::Hidester.new(row) }
    rescue Timeout::Error, LoadError, OpenURI::HTTPError
      []
    end
  end
end
