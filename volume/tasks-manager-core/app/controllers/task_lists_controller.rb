class TaskListsController < ApplicationController
  def_param_group :task_lists_desc do
    property :id, Numeric
    property :name, String
    property :description, String, required: false
    property :frequenceType, String
    property :userId, Numeric
  end

  param :name, String, required: true
  param :description, String
  param :frequenceType, %w[daily monthly weekly yearly], required: true
  api :POST, '/task_lists'
  returns :task_lists_desc, code: 201
  def create
    task_list = TaskList.create!(create_params)
    render_created(task_list)
  rescue StandardError => e
    render_unprocessable_entity(e)
  end

  api :DELETE, '/task_lists/:id'
  param :id, Numeric, required: true
  returns code: 204
  def destroy
    task_list = TaskList.find_by!(id: search_params[:id])

    authorize task_list, :owner?

    task_list.destroy!

    render_destroyed
  end

  api :GET, '/task_lists', 'array of task_lists'
  returns array_of: :task_lists_desc
  def index
    render_ok(current_user.task_lists)
  end

  api :GET, '/task_lists/:id'
  param :id, Numeric, required: true
  returns :task_lists_desc
  def show
    task_list = TaskList.find_by!(id: search_params[:id])

    authorize task_list, :owner?

    render_ok(TaskListWithTaskInListSerializer.new(task_list))
  end

  api :PUT, '/task_lists'
  param :id, Numeric, required: true
  param :name, String, required: true
  param :description, String
  param :frequence_type, %w[daily monthly weekly yearly], required: true
  returns :task_lists_desc
  def update
    task_list = TaskList.find_by!(id: search_params[:id])

    authorize task_list, :owner?
    begin
      task_list.update!(update_params)
    rescue StandardError => e
      return render_unprocessable_entity(e)
    end
    render_ok(task_list)
  end
end

private

def create_params
  params.permit(:name, :description, :frequence_type)
        .merge(user_id: current_user.id)
end

def update_params
  params.permit(:name, :description, :frequence_type)
end
