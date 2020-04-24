class AuthenticationController < ApplicationController
  post '/auth/login' do
    return render_unprocessable_entity(login_params) if invalid_params?(login_params)

    response_dto = AuthServiceHelper.login(login_params.to_json)

    render_response(response_dto)
  end

  private

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
