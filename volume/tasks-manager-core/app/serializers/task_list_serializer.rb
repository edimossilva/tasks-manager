class TaskListSerializer < ActiveModel::Serializer
  attributes :id
  attributes :name
  attributes :description
  attributes :frequence_type
  attributes :user_id
end
