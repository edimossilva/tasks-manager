class TaskListController < ApplicationController
  post '/task_lists' do
    render_unauthorized if auth_header_token.nil?

    auth_response = AuthServiceHelper.find_user_by_token(auth_header_token)

    status_code = auth_response[:headers][:status_code] || auth_response[:headers]['status_code']
    return render_error(auth_response) if status_code != 200

    data = JSON.parse(auth_response[:data])
    @user_id = data['data']['userId']

    response = CoreServiceHelper.create_task_list(create_params.to_json)

    status response[:headers]['status_code'] || response[:headers][:status_code]
    json JSON.parse(response[:data])
  end

  get '/task_lists' do
    render_unauthorized if auth_header_token.nil?

    auth_response = AuthServiceHelper.find_user_by_token(auth_header_token)

    status_code = auth_response[:headers][:status_code] || auth_response[:headers]['status_code']
    return render_error(auth_response) if status_code != 200

    data = JSON.parse(auth_response[:data])
    @user_id = data['data']['userId']

    response = CoreServiceHelper.get_task_lists(index_params.to_json)

    status response[:headers]['status_code'] || response[:headers][:status_code]
    json JSON.parse(response[:data])
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
