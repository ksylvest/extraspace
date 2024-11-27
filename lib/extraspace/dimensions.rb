# frozen_string_literal: true

module ExtraSpace
  # e.g. https://www.extraspace.com/storage/facilities/us/alabama/auburn/3264/
  class Dimensions
    # @attribute [rw] depth
    #   @return [Integer]
    attr_accessor :depth

    # @attribute [rw] width
    #  @return [Integer]
    attr_accessor :width

    # @attribute [rw] sqft
    #   @return [Integer]
    attr_accessor :sqft

    # @param depth [Integer]
    # @param width [Integer]
    # @param sqft [Integer]
    def initialize(depth:, width:, sqft:)
      @depth = depth
      @width = width
      @sqft = sqft
    end

    # @return [String]
    def inspect
      props = [
        "depth=#{@depth.inspect}",
        "width=#{@width.inspect}",
        "sqft=#{@sqft.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @param data [Hash]
    #
    # @return [Dimensions]
    def self.parse(data:)
      new(depth: data['depth'], width: data['width'], sqft: data['squareFoot'])
    end
  end
end
