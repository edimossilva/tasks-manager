class GetTaskListsService
  include Auth::JsonWebTokenHelper

  def call(payload_json)
    @payload = JSON.parse(payload_json)

    return unauthorized unless find_tasks_params[:user_id].is_a? Numeric

    @task_lists = TaskList.where(find_tasks_params)

    task_list_data
  end

  private

  def task_list_data
    hash_task_lists = @task_lists.map do |task_list|
      TaskListSerializer.new(task_list).attributes
    end

    {
      headers: { "status_code": 200 },
      payload: {
        data: hash_task_lists
      }
    }
  end

  def unauthorized
    {
      headers: { "status_code": 401 },
      payload: {
        errors: [{
          error_message: 'unauthorized =z'
        }]
      }
    }
  end

  def find_tasks_params
    { user_id: @payload['user_id'] }
  end
end
