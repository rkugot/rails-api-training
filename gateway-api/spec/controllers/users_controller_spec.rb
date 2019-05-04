require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  it { should route(:post, '/login').to(action: :login) }
  context 'valid request' do
    before do
      stub_request(:get, 'http://localhost:3040/users?filter%5Bemail%5D=test%40gmail.com&filter%5Bpassword%5D=password')
        .to_return(headers: { content_type: 'application/json' },
                   body: file_fixture('user.json').read)
      post 'login', params: { email: 'test@gmail.com', password: 'password' }
    end

    it 'should return error false' do
      expect(JSON.parse(response.body)['error']).to eq false
    end

    it 'should return api-key' do
      expect(JSON.parse(response.body)['api_key']).to eq 'foo'
    end
  end

  context 'invalid request' do
    before do
      stub_request(:get, 'http://localhost:3040/users?filter%5Bemail%5D=error%40gmail.com&filter%5Bpassword%5D=password')
      post 'login', params: { email: 'error@gmail.com', password: 'password' }
    end

    it 'should return error true' do
      expect(JSON.parse(response.body)['error']).to eq true
    end

    it 'should return error message' do
      expect(JSON.parse(response.body)['message']).to eq 'Incorrect email or password'
    end
  end
end
