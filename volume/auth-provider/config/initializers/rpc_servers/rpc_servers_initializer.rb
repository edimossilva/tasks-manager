Rails.application.configure do
  config.after_initialize do
    sleep 10

    AuthProviderServer.instance.start
  end
end
