class AuthenticationController < ApplicationController
  post '/auth/login' do
    AuthClient.instance.call(login_params)
  end

  private

  def login_params
    { username: body_params['username'],
      password: body_params['password'] }.to_json
  end
end
