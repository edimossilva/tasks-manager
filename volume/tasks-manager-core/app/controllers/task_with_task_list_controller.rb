class TaskWithTaskListController < ApplicationController
  def create
    task_list = TaskList.find_by!(find_task_list)

    task = Task.find_by(find_task_params) || Task.create!(create_params)

    TaskInList.create!(task: task, task_list: task_list)
    render_created(task)
  end

  private

  def find_task_params
    params.permit(:name).merge(user_id: current_user.id)
  end

  def find_task_list
    {
      id: params[:task_list_id],
      user_id: current_user.id
    }
  end

  def create_params
    params.permit(:name, :description)
          .merge(user_id: current_user.id)
  end
end
