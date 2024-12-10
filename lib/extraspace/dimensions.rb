# frozen_string_literal: true

module ExtraSpace
  # The dimensions (width + depth + sqft) of a price.
  class Dimensions
    DEFAULT_HEIGHT = 8.0 # feet

    # @attribute [rw] depth
    #   @return [Float]
    attr_accessor :depth

    # @attribute [rw] width
    #  @return [Float]
    attr_accessor :width

    # @attribute [rw] height
    #   @return [Float]
    attr_accessor :height

    # @param data [Hash]
    #
    # @return [Dimensions]
    def self.parse(data:)
      new(depth: data['depth'], width: data['width'], height: DEFAULT_HEIGHT)
    end

    # @param depth [Float]
    # @param width [Float]
    # @param height [Float]
    def initialize(depth:, width:, height: DEFAULT_HEIGHT)
      @depth = depth
      @width = width
      @height = height
    end

    # @return [String]
    def inspect
      props = [
        "depth=#{@depth.inspect}",
        "width=#{@width.inspect}",
        "height=#{@height.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @return [Integer]
    def sqft
      Integer(@width * @depth)
    end

    # @return [Integer]
    def cuft
      Integer(@width * @depth * @height)
    end

    # @return [String] e.g. "10' × 10' (100 sqft)"
    def text
      "#{format('%g', @width)}' × #{format('%g', @depth)}' (#{sqft} sqft)"
    end
  end
end
