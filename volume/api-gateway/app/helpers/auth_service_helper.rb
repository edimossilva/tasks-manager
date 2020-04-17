module AuthServiceHelper
  module_function

  def login(params)
    AuthClients::LoginClient.instance.call(params)
  end
end
