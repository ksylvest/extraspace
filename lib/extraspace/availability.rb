# frozen_string_literal: true

module ExtraSpace
  # e.g. https://www.extraspace.com/storage/facilities/us/alabama/auburn/3264/
  class Availability
    # @attribute [rw] available
    #   @return [String]
    attr_accessor :available

    # @param available [String]
    def initialize(available:)
      @available = available
    end

    # @return [String]
    def inspect
      props = [
        "available=#{@available.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @param data [Hash]
    #
    # @return [Availability]
    def self.parse(data:)
      new(available: data['available'])
    end
  end
end
