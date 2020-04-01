class TaskList < ApplicationRecord

  belongs_to :user, required: true
  has_many :task_in_lists, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :frequence_type, presence: true

  enum frequence_type: { daily: 0, monthly: 1, weekly: 2, yearly: 3 }

end
