class TaskInList < ApplicationRecord
  belongs_to :task_list, optional: false
  belongs_to :task, optional: false

  validate :same_user?

  delegate :user, to: :task

  private

  def same_user?
    return if task_list&.user == task&.user

    message = "task.user(#{task.user.id}) is different from task_list.user(#{task_list.user.id})"
    errors.add(:user, message)
  end
end
