# frozen_string_literal: true

module ExtraSpace
  # The core configuration.
  class Config
    # @attribute [rw] user_agent
    #   @return [String]
    attr_accessor :user_agent

    # @attribute [rw] timeout
    #   @return [Integer]
    attr_accessor :timeout

    def initialize
      @user_agent = ENV.fetch('EXTRASPACE_USER_AGENT', "extraspace.rb/#{VERSION}")
      @timeout = Integer(ENV.fetch('EXTRASPACE_TIMEOUT', 60))
    end
  end
end
