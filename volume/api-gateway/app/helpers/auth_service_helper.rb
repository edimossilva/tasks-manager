module AuthServiceHelper
  module_function

  def login(params)
    response = AuthClients::LoginClient.instance.call(params)

    cache_user(response)
  end

  def find_user(params)
    cached_user = find_cached_user(params)
    return cached_user if cached_user

    AuthClients::FindUserClient.instance.call(params)
  end

  def find_user_by_token(token)
    params = { token: token }.to_json
    find_user(params)
  end

  def cache_user(response)
    response_hash = JSON.parse(response[:data])
    token = response_hash['data']['token']
    RedisConnection.instance.store(token, response.to_json)
    response
  end

  def find_cached_user(params)
    token = JSON.parse(params)['token']
    RedisConnection.instance.find(token)
  end
end
