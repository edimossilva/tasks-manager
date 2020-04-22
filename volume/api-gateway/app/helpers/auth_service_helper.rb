module AuthServiceHelper
  module_function

  def login(params)
    response = AuthClients::LoginClient.instance.call(params)
    RedisCli.instance.cache_user(response) if response[:headers]['status_code'] == 200

    response
  end

  def find_user(params)
    cached_user = RedisCli.instance.find_cached_user(params)
    return cached_user if cached_user

    AuthClients::FindUserClient.instance.call(params)
  end

  def find_user_by_token(token)
    params = { token: token }.to_json
    find_user(params)
  end
end
