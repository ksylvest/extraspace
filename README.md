# ExtraSpace

[![LICENSE](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/ksylvest/extraspace/blob/main/LICENSE)
[![RubyGems](https://img.shields.io/gem/v/extraspace)](https://rubygems.org/gems/extraspace)
[![GitHub](https://img.shields.io/badge/github-repo-blue.svg)](https://github.com/ksylvest/extraspace)
[![Yard](https://img.shields.io/badge/docs-site-blue.svg)](https://extraspace.ksylvest.com)
[![CircleCI](https://img.shields.io/circleci/build/github/ksylvest/extraspace)](https://circleci.com/gh/ksylvest/extraspace)

## Installation

```bash
gem install extrapsace
```

## Usage

```ruby
require 'extraspace'

sitemap = ExtraSpace::Facility.sitemap
sitemap.links.each do |link|
  url = link.loc

  facility = ExtraSpace::Facility.fetch(url:)

  puts "Line 1: #{facility.address.line1}"
  puts "Line 2: #{facility.address.line2}"
  puts "City: #{facility.address.city}"
  puts "State: #{facility.address.state}"
  puts "ZIP: #{facility.address.zip}"
  puts "Latitude: #{facility.geocode.latitude}"
  puts "Longitude: #{facility.geocode.longitude}"
  puts

  facility.prices.each do |price|
    puts "UID: #{price.uid}"
    puts "Dimensions: #{price.dimensions.display}"
    puts "Rates: $#{price.rates.street} (street) / $#{price.rates.web} (web)"
    puts
  end
end
```
