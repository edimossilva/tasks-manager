class FindUserService
  include Auth::JsonWebTokenHelper

  def call(payload)
    payload_json = JSON.parse(payload)
    token = payload_json['token']
    find_user(token)
  end

  private

  def find_user(token)
    user = user_by_token(token)
    if user
      user_data(user)
    else
      unauthorized_data
    end
  end

  def user_data(user)
    {
      headers: { "status_code": 200 },
      payload: {
        data: {
          username: user.username,
          userId: user.id
        }
      }
    }
  end

  def unauthorized_data
    {
      headers: { "status_code": 401 },
      payload: {
        errors: [{
          error_message: 'unauthorized :('
        }]
      }
    }
  end
end
