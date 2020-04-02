require 'rails_helper'

RSpec.describe TaskList, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:user_id) }

  it { should validate_presence_of(:frequence_type) }
  it { should define_enum_for(:frequence_type).with_values(%i[daily monthly weekly yearly]) }

  it { should belong_to(:user) }
  it { should have_many(:task_in_lists).dependent(:destroy) }
end
