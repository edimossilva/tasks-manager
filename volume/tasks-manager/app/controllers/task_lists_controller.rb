class TaskListsController < ApplicationController
  api :POST, '/task_lists'
  param :name, String, required: true
  param :description, String
  param :frequence_type, %w[daily monthly weekly yearly], required: true
  def create
    task_list = TaskList.create!(create_params)

    render_created(task_list)
  end

  api :DELETE, '/task_lists/:id'
  param :id, Numeric, required: true
  def destroy
    task_list = TaskList.find_by!(id: search_params[:id])

    authorize task_list, :owner?

    task_list.destroy!

    render_destroyed
  end

  api :GET, '/task_lists'
  def index
    render_ok(current_user.task_lists)
  end

  api :GET, '/task_lists/:id'
  param :id, Numeric, required: true
  def show
    task_list = TaskList.find_by!(id: search_params[:id])

    authorize task_list, :owner?

    render_ok(task_list)
  end

  api :PUT, '/task_lists'
  param :id, Numeric, required: true
  param :name, String, required: true
  param :description, String
  param :frequence_type, %w[daily monthly weekly yearly], required: true
  def update
    task_list = TaskList.find_by!(id: search_params[:id])

    authorize task_list, :owner?

    task_list.update!(update_params)

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
