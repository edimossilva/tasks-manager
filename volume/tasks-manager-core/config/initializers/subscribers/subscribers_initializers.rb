Rails.application.configure do
  Subscribers::CreateTaskListSubscriber.instance.start
rescue StandardError => e
  Rails.logger.error e
end
