class AuthenticationController < ApplicationController
  post '/auth/login' do
    response = AuthClient.instance.call(login_params)
    status response[:headers]['status_code'] || response[:headers][:status_code]
    json JSON.parse(response[:data])
  end

  private

  def login_params
    { username: body_params['username'],
      password: body_params['password'] }.to_json
  end
end
