require 'rails_helper'

RSpec.describe 'CleanTestData', type: :request do
  context '#index' do
    context 'When test user has many tasks and tasklists' do
      let!(:test_user) { create(:user, :registred, username: 'test_user') }
      let!(:task_lists) { create_list(:task_list, 5, user: test_user) }
      let!(:task) { create_list(:task, 5, user: test_user) }

      before do
        DeleteTestDataWorker.new.perform
      end

      it 'delete all tasklists' do
        expect(TaskList.where(user: test_user).length).to eq(0)
      end

      it 'delete all tasks' do
        expect(Task.where(user: test_user).length).to eq(0)
      end
    end
  end
end
