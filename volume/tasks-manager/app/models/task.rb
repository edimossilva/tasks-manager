class Task < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :task_in_lists, dependent: :destroy
end
