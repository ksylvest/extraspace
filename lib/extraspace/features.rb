# frozen_string_literal: true

module ExtraSpace
  # The features (e.g. climate-controlled, inside-drive-up-access, outside-drive-up-access, etc) of a price.
  class Features
    FIRST_FLOOR_ACCESS_NAME = '1stFloorAccess'
    CLIMATE_CONTROLLED_NAME = 'ClimateControlled'
    DRIVE_UP_ACCESS_NAME = 'DriveUpAccess'
    ELEVATOR_ACCESS_NAME = 'ElevatorAccess'

    # @param data [Array<Hash>]
    #
    # @return [Features]
    def self.parse(data:)
      new(
        climate_controlled: data.any? { |feature| feature['name'].eql?(CLIMATE_CONTROLLED_NAME) },
        drive_up_access: data.any? { |feature| feature['name'].eql?(DRIVE_UP_ACCESS_NAME) },
        elevator_access: data.any? { |feature| feature['name'].eql?(ELEVATOR_ACCESS_NAME) },
        first_floor_access: data.any? { |feature| feature['name'].eql?(FIRST_FLOOR_ACCESS_NAME) }
      )
    end

    # @param climate_controlled [Boolean]
    # @param drive_up_access [Boolean]
    # @param first_floor_access [Boolean]
    def initialize(climate_controlled:, drive_up_access:, elevator_access:, first_floor_access:)
      @climate_controlled = climate_controlled
      @drive_up_access = drive_up_access
      @elevator_access = elevator_access
      @first_floor_access = first_floor_access
    end

    # @return [String]
    def inspect
      props = [
        "climate_controlled=#{@climate_controlled}",
        "drive_up_access=#{@drive_up_access}",
        "elevator_access=#{@elevator_access}",
        "first_floor_access=#{@first_floor_access}"
      ]

      "#<#{self.class.name} #{props.join(' ')}>"
    end

    # @return [String] e.g. "Climate Controlled + First Floor Access"
    def text
      amenities.join(' + ')
    end

    # @return [Array<String>]
    def amenities
      [].tap do |amenities|
        amenities << 'Climate Controlled' if climate_controlled?
        amenities << 'Drive-Up Access' if drive_up_access?
        amenities << 'Elevator Access' if elevator_access?
        amenities << 'First Floor Access' if first_floor_access?
      end
    end

    # @return [Boolean]
    def climate_controlled?
      @climate_controlled
    end

    # @return [Boolean]
    def drive_up_access?
      @drive_up_access
    end

    # @return [Boolean]
    def elevator_access?
      @elevator_access
    end

    # @return [Boolean]
    def first_floor_access?
      @first_floor_access
    end
  end
end
