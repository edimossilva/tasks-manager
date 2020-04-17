class TaskInListSerializer
  attributes :id, :checked
  attributes :task

  def task
    TaskSerializer.new(object.task)
  end
end
