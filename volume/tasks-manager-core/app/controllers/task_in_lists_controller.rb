class TaskInListsController < ApplicationController
  def_param_group :task_in_lists_desc do
    property :id, Numeric
    property :taskId, Numeric
    property :taskListId, Numeric
  end

  api :POST, '/task_in_lists'
  param :taskId, Numeric, required: true
  param :taskListId, Numeric, required: true
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

  api :PUT, '/task_in_lists/:id'
  param :id, Numeric, required: true
  param :checked, [true, false], required: true
  returns :task_in_lists_desc
  def update
    task_in_list = TaskInList.find_by!(search_params)

    authorize task_in_list, :owner?

    task_in_list.update!(update_params)

    render_ok(task_in_list)
  end

  private

  def create_params
    params.permit(:task_id, :task_list_id, :checked)
  end

  def update_params
    params.permit(:checked)
  end
end
