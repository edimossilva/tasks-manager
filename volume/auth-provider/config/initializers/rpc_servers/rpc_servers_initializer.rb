Rails.application.configure do
  config.after_initialize do
    AuthProviderServer.instance.start('rpc_login')
  end
end
