require_relative '../spec_helper.rb'

module RSpecMixin
  include Rack::Test::Methods
  def app
    AuthenticationController
  end
end

RSpec.describe 'AuthenticationController' do
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

  let(:mb_service_unavailable_data) do
    {
      errors: [
        error_message: 'Could not establish TCP connection to any of the configured hosts'
      ]
    }.to_json
  end

  let(:cache_service_unavailable_data) do
    {
      errors: [
        error_message: 'Redis::CannotConnectError'
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

  let(:body) do
    { username: 'username', password: 'passwors' }.to_json
  end

  context 'When parameters are sent' do
    context 'and parameters are valids' do
      before do
        # mock message broker
        allow(AuthClients::LoginClient).to receive(:new).and_return({})
        allow_any_instance_of(Hash).to receive(:call).and_return(success_login_payload)

        # mock cache
        allow(RedisCli).to receive(:new).and_return({})
        allow_any_instance_of(Hash).to receive(:cache_user).and_return(true)

        post(login_url, body)
      end

      it { expect(last_response.status).to eq 200 }

      it { expect(last_response.body).to eq success_login_data }
    end

    context 'and parameters are NOT valids' do
      before do
        # mock message broker
        allow(AuthClients::LoginClient).to receive(:new).and_return({})
        allow_any_instance_of(Hash).to receive(:call).and_return(unauthorized_login_payload)

        post(login_url, body)
      end

      it { expect(last_response.status).to eq 401 }

      it { expect(last_response.body).to eq unauthorized_login_data }
    end

    context 'and message broker is not working' do
      before do
        # mock message broker
        allow(AuthClients::LoginClient).to receive(:instance).and_raise(Bunny::TCPConnectionFailedForAllHosts)

        post(login_url, body)
      end

      it { expect(last_response.status).to eq 503 }

      it { expect(last_response.body).to eq mb_service_unavailable_data }
    end

    context 'and cache is not working' do
      before do
        # mock message broker
        allow(AuthClients::LoginClient).to receive(:new).and_return({})
        allow_any_instance_of(Hash).to receive(:call).and_return(success_login_payload)

        # mock cache
        allow(RedisCli).to receive(:instance).and_raise(Redis::CannotConnectError)

        post(login_url, body)
      end

      it { expect(last_response.status).to eq 503 }

      it { expect(last_response.body).to eq cache_service_unavailable_data }
    end
  end

  context 'When parameters are not sent' do
    before { post '/auth/login' }
    it { expect(last_response.status).to eq 415 }
  end
end
