class TaskListController < ApplicationController
  post '/task_lists' do
    render_unauthorized if auth_header_token.nil?

    @user_id = AuthServiceHelper.user_id_by_token(auth_header_token)

    return render_unauthorized if @user_id.nil?

    response = CoreServiceHelper.create_task_list(create_params.to_json)

    status response[:headers]['status_code'] || response[:headers][:status_code]
    json JSON.parse(response[:data])
  end

  private

  def create_params
    {
      user_id: @user_id,
      name: body_params['name'],
      description: body_params['description'],
      frequence_type: body_params['frequenceType']
    }
  end
end
