# frozen_string_literal: true

require 'http'
require 'nokogiri'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect 'extraspace' => 'ExtraSpace'
loader.setup

module ExtraSpace
  class Error < StandardError; end
end
