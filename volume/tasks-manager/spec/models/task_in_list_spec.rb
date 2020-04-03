require 'rails_helper'

RSpec.describe TaskInList, type: :model do
  it { should belong_to(:task) }
  it { should belong_to(:task_list) }

  describe 'When task and task_list have different user' do
    let!(:task) {create(:task)}
    let!(:task_list) {create(:task_list)}

    it 'is invalid' do
      task_in_list = TaskInList.new(task_list_id: task_list.id, task_id: task.id)
      expect(task_in_list).to_not be_valid
    end
  end

  describe 'When task and task_list have same user' do
    let!(:task_in_list) {create(:task_in_list)}

    it { expect(task_in_list).to be_valid }
  end
end
