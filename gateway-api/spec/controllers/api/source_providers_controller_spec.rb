require 'rails_helper'

RSpec.describe Api::SourceProvidersController, type: :controller do
  context 'not authorized user' do
    it 'should get an error' do
      stub_request(:get, 'http://localhost:3040/users?filter%5Bapi_key%5D=foo')
      get(:index, session: { api_key: 'foo' })
      expect(JSON.parse(response.body)['error']).to eq 'Access Denied'
    end
  end

  context 'authorized user' do
    before do
      allow_any_instance_of(Api::BaseController)
        .to receive(:authorize_user).and_return(true)
      stub_request(:get, 'http://localhost:3030/source-providers')
        .to_return(headers: { content_type: 'application/json' },
                   body: file_fixture('source_providers.json').read)
      stub_request(:get, 'http://localhost:3030/source-providers/1')
        .to_return(headers: { content_type: 'application/json' },
                   body: file_fixture('source_providers.json').read)
      stub_request(:get, 'http://localhost:3030/source-providers/3')
        .to_return(headers: { content_type: 'application/json' },
                   body: file_fixture('source_provider.json').read)
    end

    it 'should get index action' do
      get(:index, session: { api_key: 'foo' })
      res = JSON.parse(response.body)
      expect(res.length).to eq 2
      expect(res.first['attributes']['name']).to eq 'bank'
      expect(res.last['attributes']['name']).to eq 'alfa'
    end

    it 'should get show action' do
      get(:show, params: { id: 1 }, session: { api_key: 'foo' })
      res = JSON.parse(response.body).first
      expect(res['attributes']['name']).to eq 'bank'
      expect(res['attributes']['url']).to eq 'api-url'
    end

    it 'should get error for non active provider' do
      get(:show, params: { id: 3 }, session: { api_key: 'foo' })
      expect(JSON.parse(response.body)['error']).to eq 'This Source Provider is not active'
    end
  end
end
