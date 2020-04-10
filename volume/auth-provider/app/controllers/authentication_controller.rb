# frozen_string_literal: true

class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  def_param_group :authentication_desc do
    property :token, String
    property :exp, String
    property :username, String
    property :userId, String
  end

  api :POST, '/auth/login'
  param :username, String, required: true, desc: 'eg: registered_user1 2'
  param :password, String, required: true, desc: 'eg: 111'
  returns :authentication_desc
  def login
    user = User.find_by(username: login_params[:username])

    if user&.authenticate(login_params[:password])
      token = encode_user(user)
      time = Time.zone.now + 24.hours.to_i
      json = {
        token: token,
        exp: time.strftime('%m-%d-%Y %H:%M'),
        username: user.username,
        userId: user.id
      }
      render json: json, status: :ok
    else
      render_unauthorized
    end
  end

  private

  def login_params
    params.permit(:username, :password)
  end
end
