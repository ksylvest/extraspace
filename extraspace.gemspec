# frozen_string_literal: true

require_relative 'lib/extraspace/version'

Gem::Specification.new do |spec|
  spec.name = 'extraspace'
  spec.version = ExtraSpace::VERSION
  spec.authors = ['Kevin Sylvestre']
  spec.email = ['kevin@ksylvest.com']

  spec.summary = 'A crawler for ExtraSpace.'
  spec.description = 'Uses HTTP.rb to scrape extraspace.com.'
  spec.homepage = 'https://github.com/ksylvest/extraspace'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2.0'

  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  spec.files = Dir.glob('{bin,lib,exe}/**/*') + %w[README.md Gemfile]
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'http'
  spec.add_dependency 'json'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'zeitwerk'
end
