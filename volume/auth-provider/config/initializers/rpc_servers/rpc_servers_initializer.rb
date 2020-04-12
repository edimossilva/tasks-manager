Rails.application.configure do
  config.after_initialize do
    sleep 3

    AuthProviderServer.instance.start
  end
end
