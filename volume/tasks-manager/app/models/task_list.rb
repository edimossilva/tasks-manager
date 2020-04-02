class TaskList < ApplicationRecord
  belongs_to :user, optional: false
  has_many :task_in_lists, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :frequence_type, presence: true

  enum frequence_type: { daily: 0, monthly: 1, weekly: 2, yearly: 3 }
end
