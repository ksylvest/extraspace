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

    # @attribute [rw] features
    #   @return [Features]
    attr_accessor :features

    # @attribute [rw] rates
    #   @return [Rates]
    attr_accessor :rates

    # @param data [Hash]
    #
    # @return [Price]
    def self.parse(data:)
      new(
        id: data['uid'],
        dimensions: Dimensions.parse(data: data['dimensions']),
        features: Features.parse(data: data['features']),
        rates: Rates.parse(data: data['rates'])
      )
    end

    # @param id [String]
    # @param dimensions [Dimensions]
    # @param features [Features]
    # @param rates [Rates]
    def initialize(id:, dimensions:, features:, rates:)
      @id = id
      @dimensions = dimensions
      @features = features
      @rates = rates
    end

    # @return [String]
    def inspect
      props = [
        "id=#{@id.inspect}",
        "dimensions=#{@dimensions.inspect}",
        "features=#{@features.inspect}",
        "rates=#{@rates.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @return [String] e.g. "123 | 5' × 5' (25 sqft) | $100 (street) / $90 (web)"
    def text
      "#{@id} | #{@dimensions.text} | #{@rates.text}"
    end
  end
end
