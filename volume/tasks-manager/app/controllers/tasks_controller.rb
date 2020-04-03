class TasksController < ApplicationController
  def create
    task = Task.create!(create_params)

    render_created(task)
  end

  def destroy
    task = Task.find_by!(search_params)

    authorize task, :owner?

    task.destroy!

    render_destroyed
  end

  def update
    task = Task.find_by!(search_params)

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
