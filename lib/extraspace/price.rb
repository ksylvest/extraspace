# frozen_string_literal: true

module ExtraSpace
  # e.g. https://www.extraspace.com/storage/facilities/us/alabama/auburn/3264/
  class Price
    # @attribute [rw] uid
    #   @return [String]
    attr_accessor :uid

    # @attribute [rw] dimensions
    #   @return [Dimensions]
    attr_accessor :dimensions

    # @attribute [rw] rates
    #   @return [Rates]
    attr_accessor :rates

    # @param uid [String]
    # @param dimensions [Dimensions]
    # @param rates [Rates]
    def initialize(uid:, dimensions:, rates:)
      @uid = uid
      @dimensions = dimensions
      @rates = rates
    end

    # @return [String]
    def inspect
      props = [
        "uid=#{@uid.inspect}",
        "dimensions=#{@dimensions.inspect}",
        "rates=#{@rates.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @param data [Hash]
    #
    # @return [Price]
    def self.parse(data:)
      dimensions = Dimensions.parse(data: data['dimensions'])
      rates = Rates.parse(data: data['rates'])
      new(
        uid: data['uid'],
        dimensions: dimensions,
        rates: rates
      )
    end
  end
end
