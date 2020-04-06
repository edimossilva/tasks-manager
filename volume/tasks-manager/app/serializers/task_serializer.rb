class TaskSerializer < ActiveModel::Serializer
  attributes :id
  attributes :name
  attributes :description
  attributes :user_id
end
