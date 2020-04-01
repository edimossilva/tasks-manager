
require 'rails_helper'

RSpec.describe Task, type: :model do

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should have_many(:task_in_lists).dependent(:destroy) }

end