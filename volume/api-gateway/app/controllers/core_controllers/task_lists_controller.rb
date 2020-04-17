class TaskListController < ApplicationController
  post '/task_lists' do
    response = CoreServiceHelper.create_task_list(create_params.to_json)
    status response[:headers]['status_code'] || response[:headers][:status_code]
    json JSON.parse(response[:data])
  end

  private

  def create_params
    {
      name: body_params['name'],
      description: body_params['description'],
      frequence_type: body_params['frequenceType']
    }
  end
end
