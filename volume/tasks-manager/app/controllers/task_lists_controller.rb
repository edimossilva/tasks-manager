class TaskListsController < ApplicationController
  def create
    task_list = TaskList.new(create_params)

    authorize task_list

    task_list.save!

    render_created(task_list)
  end
end

private

def create_params
  params.permit(:name, :description, :frequence_type, :user_id)
end
