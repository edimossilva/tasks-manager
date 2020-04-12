Rails.application.configure do
  config.after_initialize do
    if ENV['RAILS_ENV'] == 'development'
      # wait message broker up
      sleep 10
      AuthProviderServer.instance.start
    end
  end
end
