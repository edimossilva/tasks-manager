Rails.application.configure do
  config.after_initialize do
    AuthProviderServer.instance.start
  end
end
