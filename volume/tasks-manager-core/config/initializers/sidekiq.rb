if ENV['RAILS_ENV'] != 'test'
  # bundle exec sidekiq

  redis_url = ENV['REDISTOGO_URL']

  Sidekiq.configure_server do |config|
    config.redis = { url: redis_url }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: redis_url }
  end
end
