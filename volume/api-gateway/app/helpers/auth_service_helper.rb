module AuthServiceHelper
  module_function

  def login(params)
    AuthClients::LoginClient.instance.call(params)
  end

  def find_user(params)
    AuthClients::FindUserClient.instance.call(params)
  end

  def find_user_by_token(token)
    params = { token: token }.to_json
    find_user(params)
  end
end
