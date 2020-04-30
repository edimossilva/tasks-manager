class TaskInList < ApplicationRecord
  belongs_to :task_list, optional: false
  belongs_to :task, optional: false

  validate :same_user?, :task_new_to_task_list?

  delegate :user, to: :task

  private

  def same_user?
    return if task_list&.user == task&.user

    message = "task.user(#{task.user.id}) is different from task_list.user(#{task_list.user.id})"
    errors.add(:user, message)
  end

  def task_new_to_task_list?
    task_in_list = TaskInList.find_by(task: task, task_list: task_list)
    return if task_in_list == self || task_in_list.nil?

    message = "task(id:#{task.id}, name:#{task.name}) already exist in task_list(id:#{task_list.id},name:#{task_list.name})"
    errors.add(:task, message)
  end
end
