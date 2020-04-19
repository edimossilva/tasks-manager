class GetTaskListsService
  include Auth::JsonWebTokenHelper

  def call(payload_json)
    @payload = JSON.parse(payload_json)

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

  def unprocessable_entity
    {
      headers: { "status_code": 422 },
      payload: {
        errors: [{
          error_message: 'unprocessable entity :('
        }]
      }
    }
  end

  def find_tasks_params
    { user_id: @payload['user_id'] }
  end
end
