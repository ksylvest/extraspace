# frozen_string_literal: true

module ExtraSpace
  # e.g. https://www.extraspace.com/storage/facilities/us/alabama/auburn/3264/
  class Geocode
    # @attribute [rw] latitude
    #   @return [Float]
    attr_accessor :latitude

    # @attribute [rw] longitude
    #   @return [Float]
    attr_accessor :longitude

    # @param latitude [Float]
    # @param longitude [Float]
    def initialize(latitude:, longitude:)
      @latitude = latitude
      @longitude = longitude
    end

    # @return [String]
    def inspect
      props = [
        "latitude=#{@latitude.inspect}",
        "longitude=#{@longitude.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @param data [Hash]
    #
    # @return [Geocode]
    def self.parse(data:)
      new(
        latitude: data['latitude'],
        longitude: data['longitude']
      )
    end
  end
end
