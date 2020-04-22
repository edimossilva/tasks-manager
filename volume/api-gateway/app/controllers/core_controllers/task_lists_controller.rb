class TaskListController < ApplicationController
  post '/task_lists' do
    render_unauthorized if auth_header_token.nil?

    auth_response_dto = AuthServiceHelper.find_user_by_token(auth_header_token)

    return render_error(auth_response_dto) if auth_response_dto.error?

    @user_id = auth_response_dto.data['userId']

    response_dto = CoreServiceHelper.create_task_list(create_params.to_json)

    status response_dto.status_code
    json response_dto.data
  end

  get '/task_lists' do
    render_unauthorized if auth_header_token.nil?

    auth_response_dto = AuthServiceHelper.find_user_by_token(auth_header_token)

    return render_error(auth_response_dto) if auth_response_dto.error?

    @user_id = auth_response_dto.data['userId']

    response_dto = CoreServiceHelper.get_task_lists(index_params.to_json)

    status response_dto.status_code
    json response_dto.data
  end

  private

  def index_params
    { user_id: @user_id }
  end

  def create_params
    {
      user_id: @user_id,
      name: body_params['name'],
      description: body_params['description'],
      frequence_type: body_params['frequenceType']
    }
  end
end
