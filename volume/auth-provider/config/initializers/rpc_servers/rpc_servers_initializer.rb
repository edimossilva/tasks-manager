Rails.application.configure do
  if ENV['RAILS_ENV'] == 'development' || ENV['RAILS_ENV'] == 'production'
    AuthProviderServer.instance.start
    FindUserServer.instance.start
  end
rescue StandardError => e
  Rails.logger.error e
end
