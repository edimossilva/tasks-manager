module AuthServiceHelper
  module_function

  def login(params)
    response = AuthClients::LoginClient.instance.call(params)
    response_dto = ResponseDto.new(response)

    RedisCli.instance.cache_user(response_dto) if response_dto.success?

    response_dto
  rescue StandardError => e
    ResponsesDto.server_unavailable(e)
  end

  def find_user(params)
    cached_user = RedisCli.instance.find_cached_user(params)
    return ResponseDto.new(cached_user) if cached_user

    response = AuthClients::FindUserClient.instance.call(params)
    ResponseDto.new(response)
  end

  def find_user_by_token(token)
    params = { token: token }.to_json
    find_user(params)
  end
end
