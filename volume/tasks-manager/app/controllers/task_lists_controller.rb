class TaskListsController < ApplicationController
  def create
    task_list = TaskList.create!(create_params)

    render_created(task_list)
  end

  def destroy
    task_list = TaskList.find_by!(id: search_params[:id])

    authorize task_list, :owner?

    task_list.destroy!

    render_destroyed
  end

  def index
    render_ok(current_user.task_lists)
  end

  def show
    task_list = TaskList.find_by!(id: search_params[:id])

    authorize task_list, :owner?

    render_ok(task_list)
  end

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
