# frozen_string_literal: true

module ExtraSpace
  # e.g. https://www.extraspace.com/storage/facilities/us/alabama/auburn/3264/
  class Rates
    # @attribute [rw] street
    #   @return [Integer]
    attr_accessor :street

    # @attribute [rw] web
    #   @return [Integer]
    attr_accessor :web

    # @param street [Integer]
    # @param web [Integer]
    def initialize(street:, web:)
      @street = street
      @web = web
    end

    # @return [String]
    def inspect
      props = [
        "street=#{@street.inspect}",
        "web=#{@web.inspect}"
      ]
      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @param data [Hash]
    #
    # @return [Rates]
    def self.parse(data:)
      new(
        street: data['street'],
        web: data['web']
      )
    end
  end
end
