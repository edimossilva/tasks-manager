class CreateTaskListService
  include Auth::JsonWebTokenHelper

  def call(payload_json)
    @payload = JSON.parse(payload_json)

    @task_list = TaskList.new(create_task_params)
    if @task_list.save
      task_list_data
    else
      unprocessable_entity
    end
  end

  private

  def task_list_data
    {
      headers: { "status_code": 200 },
      payload: {
        data: TaskListSerializer.new(@task_list).attributes
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

  def create_task_params
    {
      user_id: @payload['user_id'],
      name: @payload['name'],
      description: @payload['description'],
      frequence_type: @payload['frequence_type']
    }
  end
end
