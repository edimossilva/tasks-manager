Rails.application.configure do
  if ENV['RAILS_ENV'] == 'development' || ENV['RAILS_ENV'] == 'production'
    AuthProviderSubscriber.instance.start
    FindUserSubscriber.instance.start
  end
rescue StandardError => e
  Rails.logger.error e
end
