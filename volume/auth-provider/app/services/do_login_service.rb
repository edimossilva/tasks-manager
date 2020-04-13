class DoLoginService
  include Auth::JsonWebTokenHelper

  def call(payload)
    payload_json = JSON.parse(payload)
    username = payload_json['username']
    password = payload_json['password']

    user = User.find_by(username: username)
    if user&.authenticate(password)
      auth_data(user)
    else
      unauthorized_data
    end
  end

  private

  def exp_time
    time = Time.zone.now + 24.hours.to_i
    time.strftime('%m-%d-%Y %H:%M')
  end

  def auth_data(user)
    {
      headers: { "status_code": 200 },
      data: {
        token: encode_user(user),
        exp: exp_time,
        username: user.username,
        userId: user.id
      }
    }
  end

  def unauthorized_data
    {
      headers: { "status_code": 401 },
      errors: [{
        error_message: 'unauthorized :('
      }]
    }
  end
end
