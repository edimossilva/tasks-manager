require_relative '../spec_helper.rb'
# require_relative '../../app/controllers/authentication_controller.rb'
# run ApplicationController
set :show_exceptions, false

module RSpecMixin
  include Rack::Test::Methods
  def app
    AuthenticationController.new
  end
end

describe 'AuthenticationController' do
  let(:login_url) { '/auth/login' }

  let(:success_login_data) do
    {
      token: 'token',
      exp: DateTime.now.strftime('%m-%d-%Y %H:%M'),
      username: 'user.username',
      userId: 'user.id'
    }.to_json
  end

  let(:unauthorized_login_data) do
    {
      errors: [
        error_message: 'unauthorized :('
      ]
    }.to_json
  end

  let(:success_login_payload) do
    {
      headers: ok_headers,
      data: success_login_data
    }
  end

  let(:unauthorized_login_payload) do
    {
      headers: unauthorized_headers,
      data: unauthorized_login_data
    }
  end

  context 'When parameters are sent' do
    context 'and parameters are valids' do
      before do
        allow_any_instance_of(AuthClient).to receive(:initialize).and_return(true)
        allow_any_instance_of(AuthClient).to receive(:call).and_return(success_login_payload)
      end
      let(:body) { { username: 'username', password: 'passwors' }.to_json }
      let(:response) { post(login_url, body) }

      it 'returns ok(200)' do
        expect(response.status).to eq 200
      end

      it 'returns login payload' do
        expect(response.body).to eq success_login_data
      end
    end

    context 'and parameters are NOT valids' do
      before do
        allow_any_instance_of(AuthClient).to receive(:call).and_return(unauthorized_login_payload)
      end
      let(:body) { { username: 'username', password: 'passwors' }.to_json }
      let(:response) { post(login_url, body) }

      it 'returns unauthorized(401)' do
        expect(response.status).to eq 401
      end

      it 'returns unauthorized payload' do
        expect(response.body).to eq unauthorized_login_data
      end
    end
  end

  context 'When parameters are not sent' do
    let(:response) { post '/auth/login' }
    it 'returns unprocessable_entity(415)' do
      expect(response.status).to eq 415
    end
  end
end
