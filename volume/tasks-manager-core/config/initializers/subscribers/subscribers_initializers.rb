Rails.application.configure do
  Subscribers::CreateTaskListSubscriber.instance.start
  Subscribers::GetTaskListsSubscriber.instance.start
rescue StandardError => e
  Rails.logger.error e
end
