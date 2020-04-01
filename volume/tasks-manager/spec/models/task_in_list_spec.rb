require 'rails_helper'

RSpec.describe TaskInList, type: :model do
  it { should belong_to(:task) }
  it { should belong_to(:task_list) }
end
