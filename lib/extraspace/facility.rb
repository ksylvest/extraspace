# frozen_string_literal: true

module ExtraSpace
  # e.g. https://www.extraspace.com/storage/facilities/us/alabama/auburn/3264/
  class Facility
    # @attribute [rw] address
    #   @return [Address]
    attr_accessor :address

    # @attribute [rw] geocode
    #   @return [Geocode]
    attr_accessor :geocode

    # @attribute [rw] prices
    #   @return [Array<Price>]
    attr_accessor :prices

    # @param address [Address]
    # @param geocode [Geocode]
    # @param prices [Array<Price>]
    def initialize(address:, geocode:, prices:)
      @address = address
      @geocode = geocode
      @prices = prices
    end

    # @return [String]
    def inspect
      props = [
        "address=#{@address.inspect}",
        "geocode=#{@geocode.inspect}",
        "prices=#{@prices.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @param url [String]
    #
    # @return [Facility]
    def self.fetch(url:)
      response = HTTP.get(url)
      document = Nokogiri::HTML(String(response.body))
      data = JSON.parse(document.at('#__NEXT_DATA__').text)

      parse(data: data)
    end

    # @param data [Hash]
    #
    # @return [Facility]
    def self.parse(data:)
      page_data = data.dig('props', 'pageProps', 'pageData', 'data')
      facility_data = page_data.dig('facilityData', 'data')
      unit_classes = page_data.dig('unitClasses', 'data', 'unitClasses')

      address = Address.parse(data: facility_data['store']['address'])
      geocode = Geocode.parse(data: facility_data['store']['geocode'])
      prices = unit_classes.map { |price_data| Price.parse(data: price_data) }

      new(address:, geocode:, prices:)
    end
  end
end
