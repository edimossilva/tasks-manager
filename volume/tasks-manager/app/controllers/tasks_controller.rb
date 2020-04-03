class TasksController < ApplicationController
  def create
    task = Task.new(create_params)

    task.save!

    render_created(task)
  end

  def update
    task = Task.find_by!(id: search_params[:id])

    authorize task, :owner?

    task.update!(update_params)

    render_ok(task)
  end

  private

  def create_params
    params.permit(:name, :description)
          .merge(user_id: current_user.id)
  end

  def update_params
    params.permit(:name, :description)
  end
end
