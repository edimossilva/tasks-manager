class TaskInListSerializer < ActiveModel::Serializer
  attributes :id
  attributes :checked
  attributes :task

  def task
    TaskSerializer.new(object.task)
  end
end
