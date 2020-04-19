Rails.application.configure do
  RpcSubscribers::Tasklist::CreateTaskListSubscriber.instance.start
  RpcSubscribers::Tasklist::GetTaskListsSubscriber.instance.start
rescue StandardError => e
  Rails.logger.error e
end
