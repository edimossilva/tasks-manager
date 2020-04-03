class Task < ApplicationRecord
  belongs_to :user, optional: false
  has_many :task_in_lists, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }
end
