Rails.application.configure do
  config.after_initialize do
    AuthProviderServer.instance.start if ENV['RAILS_ENV'] == 'development' || ENV['RAILS_ENV'] == 'production'
  end
end
