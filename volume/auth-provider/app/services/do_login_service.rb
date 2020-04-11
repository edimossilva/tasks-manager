class DoLoginService
  include Auth::JsonWebTokenHelper

  def call(payload)
    payload_json = JSON.parse(payload)
    username = payload_json['username']
    password = payload_json['password']

    user = User.find_by(username: username)
    if user&.authenticate(password)
      auth_data_json(user)
    else
      unauthorized_json
    end
  end

  private

  def exp_time
    time = Time.zone.now + 24.hours.to_i
    time.strftime('%m-%d-%Y %H:%M')
  end

  def auth_data_json(user)
    {
      token: encode_user(user),
      exp: exp_time,
      username: user.username,
      userId: user.id
    }.to_json
  end

  def unauthorized_json
    {
      status: 401
    }.to_json
  end
end
