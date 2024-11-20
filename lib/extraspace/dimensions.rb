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

    # @attribute [rw] display
    #   @return [String]
    attr_accessor :display

    # @param uid [String]
    def initialize(depth:, width:, sqft:, display:)
      @depth = depth
      @width = width
      @sqft = sqft
      @display = display
    end

    # @return [String]
    def inspect
      props = [
        "depth=#{@depth.inspect}",
        "width=#{@width.inspect}",
        "sqft=#{@sqft.inspect}",
        "display=#{@display.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @param data [Hash]
    #
    # @return [Address]
    def self.parse(data:)
      new(depth: data['depth'], width: data['width'], sqft: data['squareFoot'], display: data['display'])
    end
  end
end
