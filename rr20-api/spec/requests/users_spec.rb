require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  context 'GET /users' do
    before do
      get '/users'
    end
    it 'should return json' do
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq 'application/vnd.api+json'
    end

    it 'should return all users' do
      expect(JSON.parse(response.body)['data'].length).to eq 3
    end
  end

  context 'GET /users/id' do
    before do
      get user_path(user1)
    end

    it 'should return json' do
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq 'application/vnd.api+json'
    end

    it 'should return user1 data' do
      user_attrs = JSON.parse(response.body)['data']['attributes']
      expect(user_attrs['first-name']).to eq user1.first_name
      expect(user_attrs['last-name']).to eq user1.last_name
      expect(user_attrs['email']).to eq user1.email
    end
  end
end
