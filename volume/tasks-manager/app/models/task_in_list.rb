class TaskInList < ApplicationRecord
  belongs_to :task_list, optional: false
  belongs_to :task, optional: false
end
