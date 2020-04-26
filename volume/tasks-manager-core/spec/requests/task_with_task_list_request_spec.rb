require 'rails_helper'

RSpec.describe 'TaskWithTaskLists', type: :request do
  let!(:registred_user) { create(:user, :registred) }
  let!(:registred_headers) { header_for_user(registred_user) }

  describe 'create' do
    let!(:task) { build(:task, user: registred_user) }
    let!(:task_list) { create(:task_list, user: registred_user) }
    let!(:create_task_params) do
      {
        name: task.name,
        description: task.description,
        task_list_id: task_list.id
      }
    end

    context 'When data is valid' do
      before do
        post('/task_with_task_list',
             params: create_task_params,
             headers: registred_headers)
      end

      it { expect(response).to have_http_status(:created) }

      it 'contains fields from params' do
        expect(json_response_data['id']).not_to be_nil
        expect(json_response_data['user_id']).to eq(registred_user.id)
        expect(json_response_data['name']).to eq(create_task_params[:name])
        expect(json_response_data['description']).to eq(create_task_params[:description])
      end

      it 'is associated with task_list by task_in_list' do
        task_id = json_response_data['id']
        task_in_list = TaskInList.find_by(task_id: task_id, task_list_id: task_list.id)
        expect(task_in_list).not_to be_nil
      end
    end

    context 'When data is NOT valid' do
      before do
        post('/task_with_task_list',
             params: {
               task_list_id: task_list.id
             },
             headers: registred_headers)
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'When task_list not found' do
      before do
        post('/task_with_task_list',
             params: {
               task_list_id: -1
             },
             headers: registred_headers)
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end
end
