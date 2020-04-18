class FindUserService < BaseService
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
      headers: status_code_ok,
      payload: {
        data: {
          username: user.username,
          userId: user.id
        }
      }
    }
  end
end
