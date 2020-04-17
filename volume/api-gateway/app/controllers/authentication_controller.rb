class AuthenticationController < ApplicationController
  post '/auth/login' do
    return render_unprocessable_entity(login_params) if invalid_params?

    response = AuthServiceHelper.login(login_params.to_json)
    status response[:headers]['status_code'] || response[:headers][:status_code]
    json JSON.parse(response[:data])
  end

  private

  def login_params
    { username: body_params['username'],
      password: body_params['password'] }
  end

  def invalid_params?
    login_params.values.any? do |value|
      value&.empty? || value.nil?
    end
  end
end
