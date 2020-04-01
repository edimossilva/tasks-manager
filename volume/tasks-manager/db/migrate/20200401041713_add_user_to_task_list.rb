class AddUserToTaskList < ActiveRecord::Migration[6.0]
  def change
    add_reference :task_lists, :user, foreign_key: true
  end
end
