# frozen_string_literal: true

module ExtraSpace
  # A facility (address + geocode + prices) on extraspace.com.
  #
  # e.g. https://www.extraspace.com/storage/facilities/us/alabama/auburn/3264/
  class Facility
    DEFAULT_EMAIL = 'info@extraspace.com'
    DEFAULT_PHONE = '1-855-518-1443'

    SITEMAP_URL = 'https://www.extraspace.com/facility-sitemap.xml'

    # @attribute [rw] id
    #   @return [String]
    attr_accessor :id

    # @attribute [rw] url
    #   @return [String]
    attr_accessor :url

    # @attribute [rw] name
    #   @return [String]
    attr_accessor :name

    # @attribute [rw] phone
    #   @return [String]
    attr_accessor :phone

    # @attribute [rw] email
    #   @return [String]
    attr_accessor :email

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
      parse(url:, document:)
    end

    # @param url [String]
    # @param document [Nokogiri::HTML::Document]
    #
    # @return [Facility]
    def self.parse(url:, document:)
      data = parse_next_data(document: document)
      page_data = data.dig('props', 'pageProps', 'pageData', 'data')
      store_data = page_data.dig('facilityData', 'data', 'store')
      id = store_data['number']
      name = store_data['name']

      address = parse_address(data: store_data)
      geocode = parse_geocode(data: store_data)
      prices = parse_prices(data: page_data)

      new(id:, url:, name:, address:, geocode:, prices:)
    end

    # @param data [Hash]
    # @return [Address]
    def self.parse_address(data:)
      Address.parse(data: data['address'])
    end

    # @param data [Hash]
    # @return [Geocode]
    def self.parse_geocode(data:)
      Geocode.parse(data: data['geocode'])
    end

    # @param entries [Array<Hash>]
    #
    # @return [Array<Price>]
    def self.parse_prices(data:)
      unit_classes = data.dig('unitClasses', 'data', 'unitClasses')

      unit_classes
        .reject { |price_data| price_data.dig('availability', 'available')&.zero? }
        .map { |price_data| Price.parse(data: price_data) }
    end

    # @param document [Nokogiri::HTML::Document]
    #
    # @raise [ParseError]
    #
    # @return [Hash]
    def self.parse_next_data(document:)
      JSON.parse(document.at('#__NEXT_DATA__').text)
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
    # @param url [String]
    # @param name [String]
    # @param address [Address]
    # @param geocode [Geocode]
    # @param phone [String]
    # @param email [String]
    # @param prices [Array<Price>]
    def initialize(id:, url:, name:, address:, geocode:, phone: DEFAULT_PHONE, email: DEFAULT_EMAIL, prices: [])
      @id = id
      @url = url
      @name = name
      @address = address
      @geocode = geocode
      @phone = phone
      @email = email
      @prices = prices
    end

    # @return [String]
    def inspect
      props = [
        "id=#{@id.inspect}",
        "url=#{@url.inspect}",
        "address=#{@address.inspect}",
        "geocode=#{@geocode.inspect}",
        "phone=#{@phone.inspect}",
        "email=#{@email.inspect}",
        "prices=#{@prices.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @return [String]
    def text
      "#{@id} | #{@name} | #{@phone} | #{@email} | #{@address.text} | #{@geocode.text}"
    end
  end
end
