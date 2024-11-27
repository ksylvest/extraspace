# frozen_string_literal: true

module ExtraSpace
  # The price (id + dimensions + rate) for a facility
  class Price
    # @attribute [rw] id
    #   @return [String]
    attr_accessor :id

    # @attribute [rw] dimensions
    #   @return [Dimensions]
    attr_accessor :dimensions

    # @attribute [rw] rates
    #   @return [Rates]
    attr_accessor :rates

    # @param id [String]
    # @param dimensions [Dimensions]
    # @param rates [Rates]
    def initialize(id:, dimensions:, rates:)
      @id = id
      @dimensions = dimensions
      @rates = rates
    end

    # @return [String]
    def inspect
      props = [
        "id=#{@id.inspect}",
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
        id: data['uid'],
        dimensions: dimensions,
        rates: rates
      )
    end
  end
end
