# frozen_string_literal: true

RSpec.describe ExtraSpace::Facility do
  describe '.fetch' do
    subject(:fetch) { described_class.fetch(url: url) }

    let(:url) { 'https://www.extraspace.com/storage/facilities/us/alabama/auburn/3264/' }

    before { VCR.use_cassette('extraspace/facility/fetch') { fetch } }

    it 'fetches and parses the facility' do
      expect(fetch).to be_a(described_class)
      expect(fetch.address).to be_a(ExtraSpace::Address)
      expect(fetch.geocode).to be_a(ExtraSpace::Geocode)
      expect(fetch.prices).to all(be_a(ExtraSpace::Price))
    end
  end
end
