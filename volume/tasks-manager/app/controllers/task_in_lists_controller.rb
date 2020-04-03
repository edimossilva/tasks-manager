class TaskInListsController < ApplicationController
  def create
    task_in_list = TaskInList.create!(create_params)

    render_created(task_in_list)
  end

  def destroy
    task_in_list = TaskInList.find_by!(search_params)

    authorize task_in_list, :owner?

    task_in_list.destroy!

    render_destroyed
  end

  private

  def create_params
    params.permit(:task_id, :task_list_id, :checked)
  end
end
