# frozen_string_literal: true

module ExtraSpace
  # The rates (street + web) for a facility
  class Rates
    # @attribute [rw] street
    #   @return [Integer]
    attr_accessor :street

    # @attribute [rw] web
    #   @return [Integer]
    attr_accessor :web

    # @param data [Hash]
    #
    # @return [Rates]
    def self.parse(data:)
      new(
        street: data['street'],
        web: data['web']
      )
    end

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

    # @return [String] e.g. "$80 (street) | $60 (web)"
    def text
      "$#{@street} (street) | $#{@web} (web)"
    end
  end
end
