require 'rails_helper'

RSpec.describe 'SourceProviders', type: :request do
  let!(:source_provider1) { create(:source_provider) }
  let!(:source_provider2) { create(:source_provider) }
  let!(:source_provider3) { create(:noactive_source_provider) }
  context 'GET /source-providers' do
    before do
      get source_providers_path
    end
    it 'should return json' do
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq 'application/vnd.api+json'
    end

    it 'should return active providers' do
      res = JSON.parse(response.body)
      expect(res['data'].length).to eq 2
    end
  end

  context 'GET /source-providers/id' do
    before do
      get source_provider_path(source_provider1)
    end
    it 'should return json' do
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq 'application/json'
    end

    it 'should show provider' do
      res_attributes = JSON.parse(response.body)['data']['attributes']
      expect(res_attributes['name']).to eq source_provider1.name
    end
  end
end
