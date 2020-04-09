class TasksController < ApplicationController
  include Producers::ProducersHelper

  def_param_group :task_desc do
    property :id, Numeric
    property :name, String
    property :description, String
    property :userId, Numeric
  end

  api :POST, '/tasks'
  param :name, String, required: true
  param :description, String
  returns :task_desc, code: 201
  def create
    task = Task.create!(create_params)

    task_json = TaskSerializer.new(task).to_json
    publish_task_created(task_json)

    render_created(task)
  end

  api :DELETE, '/tasks'
  param :id, Numeric, required: true
  returns code: 204
  def destroy
    task = Task.find_by!(search_params)

    authorize task, :owner?

    task.destroy!

    render_destroyed
  end

  api :PUT, '/tasks'
  param :id, Numeric, required: true
  param :name, String
  param :description, String
  returns :task_desc
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
