class TaskWithTaskListController < ApplicationController
  def create
    task = Task.find_by(find_task_params)
    task = Task.new(create_params) if task.nil?

    task_list = TaskList.find_by!(id: params[:task_list_id])

    task.save!

    TaskInList.create!(task: task, task_list: task_list)
    render_created(task)
  end

  private

  def find_task_params
    params.permit(:name).merge(user_id: current_user.id)
  end

  def create_params
    params.permit(:name, :description)
          .merge(user_id: current_user.id)
  end
end
