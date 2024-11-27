# frozen_string_literal: true

module ExtraSpace
  # A facility (address + geocode + prices) on extraspace.com.
  #
  # e.g. https://www.extraspace.com/storage/facilities/us/alabama/auburn/3264/
  class Facility
    SITEMAP_URL = 'https://www.extraspace.com/facility-sitemap.xml'

    # @attribute [rw] id
    #   @return [String]
    attr_accessor :id

    # @attribute [rw] name
    #   @return [String]
    attr_accessor :name

    # @attribute [rw] address
    #   @return [Address]
    attr_accessor :address

    # @attribute [rw] geocode
    #   @return [Geocode]
    attr_accessor :geocode

    # @attribute [rw] prices
    #   @return [Array<Price>]
    attr_accessor :prices

    # @return [Sitemap]
    def self.sitemap
      Sitemap.fetch(url: SITEMAP_URL)
    end

    # @param url [String]
    #
    # @return [Facility]
    def self.fetch(url:)
      document = Crawler.html(url:)
      data = JSON.parse(document.at('#__NEXT_DATA__').text)
      parse(data:)
    end

    # @param data [Hash]
    #
    # @return [Facility]
    def self.parse(data:)
      page_data = data.dig('props', 'pageProps', 'pageData', 'data')
      store_data = page_data.dig('facilityData', 'data', 'store')
      unit_classes = page_data.dig('unitClasses', 'data', 'unitClasses')
      id = store_data['number']
      name = store_data['name']

      address = Address.parse(data: store_data['address'])
      geocode = Geocode.parse(data: store_data['geocode'])
      prices = unit_classes.map { |price_data| Price.parse(data: price_data) }

      new(id:, name:, address:, geocode:, prices:)
    end

    def self.crawl
      sitemap.links.each do |link|
        url = link.loc

        facility = fetch(url:)
        puts facility.text

        facility.prices.each do |price|
          puts price.text
        end

        puts
      end
    end

    # @param id [String]
    # @param name [String]
    # @param address [Address]
    # @param geocode [Geocode]
    # @param prices [Array<Price>]
    def initialize(id:, name:, address:, geocode:, prices:)
      @id = id
      @name = name
      @address = address
      @geocode = geocode
      @prices = prices
    end

    # @return [String]
    def inspect
      props = [
        "id=#{@id.inspect}",
        "address=#{@address.inspect}",
        "geocode=#{@geocode.inspect}",
        "prices=#{@prices.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @return [String] e.g. "123 Main St, Springfield, IL 62701"
    def text
      "#{@id} | #{@name} | #{@address.text} | #{@geocode.text}"
    end
  end
end
