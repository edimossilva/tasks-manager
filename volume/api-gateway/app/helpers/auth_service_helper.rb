module AuthServiceHelper
  module_function

  def login(params)
    AuthClients::LoginClient.instance.call(params)
  end

  def find_user(params)
    AuthClients::FindUserClient.instance.call(params)
  end
end
