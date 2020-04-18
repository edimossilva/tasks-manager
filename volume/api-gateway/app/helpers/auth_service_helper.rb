module AuthServiceHelper
  module_function

  def login(params)
    AuthClients::LoginClient.instance.call(params)
  end

  def find_user(params)
    AuthClients::FindUserClient.instance.call(params)
  end

  def user_id_by_token(token)
    params = { token: token }.to_json
    response_payload = find_user(params)

    return nil unless response_payload[:headers]['status_code'] == 200

    json_response = JSON.parse(response_payload[:data])

    json_response['data']['userId']
  end
end
