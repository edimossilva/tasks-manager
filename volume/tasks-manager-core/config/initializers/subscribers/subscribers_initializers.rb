Rails.application.configure do
  Subscribers::Tasklist::CreateTaskListSubscriber.instance.start
  Subscribers::Tasklist::GetTaskListsSubscriber.instance.start
rescue StandardError => e
  Rails.logger.error e
end
