class AuthenticationController < ApplicationController
  post '/auth/login' do
    return render_unprocessable_entity(login_params) if invalid_params?(login_params)

    response = AuthServiceHelper.login(login_params.to_json)

    status response[:headers]['status_code'] || response[:headers][:status_code]
    json JSON.parse(response[:data])
  end

  post '/retrieve_user' do
    return render_unprocessable_entity(retrieve_user_params) if invalid_params?(retrieve_user_params)

    response = AuthServiceHelper.find_user(retrieve_user_params.to_json)

    status response[:headers]['status_code'] || response[:headers][:status_code]
    json JSON.parse(response[:data])
  end

  private

  def retrieve_user_params
    { token: body_params['token'] }
  end

  def login_params
    { username: body_params['username'],
      password: body_params['password'] }
  end

  def invalid_params?(current_params)
    current_params.values.any? do |value|
      value&.empty? || value.nil?
    end
  end
end
