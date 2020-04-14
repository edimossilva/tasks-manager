Rails.application.configure do
  AuthProviderServer.instance.start if ENV['RAILS_ENV'] == 'development' || ENV['RAILS_ENV'] == 'production'
rescue StandardError => e
  Rails.logger.error e
end
