module CoreServiceHelper
  module_function

  def create_task_list(params)
    response = CoreClients::CreateTaskListClient.instance.call(params)
    ResponseDto.new(response)
  end

  def get_task_lists(params)
    response = CoreClients::GetTaskListsClient.instance.call(params)
    ResponseDto.new(response)
  end
end
