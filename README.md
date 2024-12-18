# Extra Space

[![LICENSE](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/ksylvest/extraspace/blob/main/LICENSE)
[![RubyGems](https://img.shields.io/gem/v/extraspace)](https://rubygems.org/gems/extraspace)
[![GitHub](https://img.shields.io/badge/github-repo-blue.svg)](https://github.com/ksylvest/extraspace)
[![Yard](https://img.shields.io/badge/docs-site-blue.svg)](https://extraspace.ksylvest.com)
[![CircleCI](https://img.shields.io/circleci/build/github/ksylvest/extraspace)](https://circleci.com/gh/ksylvest/extraspace)

A Ruby library offering both a CLI and API for scraping [Extra Space](https://www.extraspace.com/) self-storage facilities and prices.

## Installation

```bash
gem install extraspace
```

## Configuration

```ruby
require 'extraspace'

ExtraSpace.configure do |config|
  config.user_agent = '../..' # ENV['EXTRASPACE_USER_AGENT']
  config.timeout = 30 # ENV['EXTRASPACE_TIMEOUT']
end
```

## Usage

```ruby
require 'extraspace'

sitemap = ExtraSpace::Facility.sitemap
sitemap.links.each do |link|
  url = link.loc
  facility = ExtraSpace::Facility.fetch(url:)

  puts facility.text

  facility.prices.each do |price|
    puts price.text
  end

  puts
end
```

## CLI

```bash
extraspace crawl
```

```bash
extrapsace crawl "https://www.extraspace.com/storage/facilities/us/california/los_angeles/900113/"
```
