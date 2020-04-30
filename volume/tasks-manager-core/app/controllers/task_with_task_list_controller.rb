class TaskWithTaskListController < ApplicationController
  def create
    task_list = TaskList.find_by!(find_task_list)

    task = Task.find_by(find_task_params) || Task.create!(create_params)
    # binding.pry
    task_in_list = TaskInList.create!(task: task, task_list: task_list)
    render_created(TaskInListSerializer.new(task_in_list))
  end

  private

  def find_task_params
    params.require(:name)
    params.permit(:name).merge(user_id: current_user.id)
  end

  def find_task_list
    {
      id: params[:task_list_id],
      user_id: current_user.id
    }
  end

  def create_params
    params.require(%i[name])
    params.permit(%i[name description])
          .merge(user_id: current_user.id)
  end
end
