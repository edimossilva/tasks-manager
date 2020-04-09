class TaskInListsController < ApplicationController
  def_param_group :task_in_lists_desc do
    property :id, Numeric
    property :task_id, Numeric
    property :task_list_id, Numeric
  end

  api :POST, '/task_in_lists'
  param :task_id, Numeric, required: true
  param :task_list_id, Numeric, required: true
  param :checked, [true, false], required: true
  returns :task_in_lists_desc, code: 201
  def create
    task_in_list = TaskInList.create!(create_params)

    render_created(task_in_list)
  end

  api :DELETE, '/task_in_lists/:id'
  param :id, Numeric, required: true
  returns code: 204
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
