require 'rails_helper'

RSpec.describe 'getTaskListsService', type: :service do
  let!(:user) { create :user }
  let!(:task_lists) { create_list(:task_list, 3, user: user) }

  context 'When valid user_id is sent' do
    let!(:task_params) do
      {
        user_id: user.id
      }
    end

    subject { GetTaskListsService.new.call(task_params.to_json) }

    it { expect(subject_status_code).to eq(200) }

    it { expect(subject_data.length).to eq(3) }
  end

  context 'When NOT valid user_id is sent' do
    let!(:invalid_task_params) do
      {
        user_id: ''
      }
    end

    subject { GetTaskListsService.new.call(invalid_task_params.to_json) }

    it { expect(subject_status_code).to eq(401) }

    it { expect(subject_errors[0][:error_message]).to eq('unauthorized =z') }
  end
end
