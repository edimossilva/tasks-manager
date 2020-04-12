Rails.application.configure do
  config.after_initialize do
    AuthProviderServer.instance.start('rpc_login_request')
  end
end
