require 'rails_helper'

RSpec.describe Api::CourseResultsController, type: :controller do
  it { should route(:get, '/api/courses').to(action: :index) }
  it { should route(:get, '/api/courses/history').to(action: :history) }
  it { should use_before_action(:authorize_user) }
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
      stub_request(:get, 'http://localhost:3030/courses')
        .to_return(headers: { content_type: 'application/json' },
                   body: file_fixture('courses.json').read)
      stub_request(:get, 'http://localhost:3030/courses/history')
        .to_return(headers: { content_type: 'application/json' },
                   body: file_fixture('courses_history.json').read)
    end
    it 'should get index action' do
      get(:index)
      res = JSON.parse(response.body).first
      expect(res['attributes']['usd']).to eq '2.1115'
    end

    it 'should get history action' do
      get(:history)
      res = JSON.parse(response.body)
      expect(res.length).to eq 2
    end
  end
end
