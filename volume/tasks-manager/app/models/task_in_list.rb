class TaskInList < ApplicationRecord

  belongs_to :task_list, required: true
  belongs_to :task, required: true

end
