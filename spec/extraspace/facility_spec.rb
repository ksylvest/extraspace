# frozen_string_literal: true

RSpec.describe ExtraSpace::Facility do
  describe '.sitemap' do
    subject(:sitemap) { described_class.sitemap }

    around { |example| VCR.use_cassette('extraspace/facility/sitemap', &example) }

    it 'fetches and parses the sitemap' do
      expect(sitemap).to be_a(ExtraSpace::Sitemap)
      expect(sitemap.links).to all(be_a(ExtraSpace::Link))
    end
  end

  describe '.fetch' do
    subject(:fetch) { described_class.fetch(url: url) }

    let(:url) { 'https://www.extraspace.com/storage/facilities/us/alabama/auburn/3264/' }

    around { |example| VCR.use_cassette('extraspace/facility/fetch', &example) }

    it 'fetches and parses the facility' do
      expect(fetch).to be_a(described_class)
      expect(fetch.address).to be_a(ExtraSpace::Address)
      expect(fetch.geocode).to be_a(ExtraSpace::Geocode)
      expect(fetch.prices).to all(be_a(ExtraSpace::Price))
    end
  end
end
