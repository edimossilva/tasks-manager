module CoreServiceHelper
  module_function

  def create_task_list(params)
    CoreClients::CreateTaskListClient.instance.call(params)
  end

  def get_task_lists(params)
    CoreClients::GetTaskListsClient.instance.call(params)
  end
end
