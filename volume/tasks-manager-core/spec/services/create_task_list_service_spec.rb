require 'rails_helper'

RSpec.describe 'CreateTaskListService', type: :service do
  let!(:user) { create :user }

  context 'When task_list params are valid' do
    let!(:task_params) do
      {
        user_id: user.id,
        name: 'name',
        description: 'desc',
        frequence_type: 'daily'
      }
    end

    subject { CreateTaskListService.new.call(task_params.to_json) }

    it { expect(subject_status_code).to eq(200) }

    it 'has all fields' do
      expect(subject_data[:id]).to_not be_nil
      expect(subject_data[:user_id]).to eq(user.id)
      expect(subject_data[:name]).to eq(task_params[:name])
      expect(subject_data[:description]).to eq(task_params[:description])
      expect(subject_data[:frequence_type]).to eq(task_params[:frequence_type])
    end
  end

  context 'When task_list params are NOT valid' do
    let!(:invalid_task_params) do
      {
        user_id: user.id,
        name: '',
        description: 'desc',
        frequence_type: 'daily'
      }
    end

    subject { CreateTaskListService.new.call(invalid_task_params.to_json) }

    it { expect(subject_status_code).to eq(422) }

    it { expect(subject_errors[0][:error_message]).to eq('unprocessable entity :(') }
  end
end
