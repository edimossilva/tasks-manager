class TaskListWithTaskInListSerializer < TaskListSerializer
  has_many :task_in_lists, serializer: TaskInListSerializer
end
