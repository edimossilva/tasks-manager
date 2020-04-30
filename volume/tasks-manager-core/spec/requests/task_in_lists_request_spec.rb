require 'rails_helper'

RSpec.describe 'TaskInLists', type: :request do
  let!(:registred_user) { create(:user, :registred) }
  let!(:registred_user2) { create(:user, :registred) }
  let!(:registred_headers) { header_for_user(registred_user) }
  let!(:registred_headers2) { header_for_user(registred_user2) }
  let!(:task_list) { create(:task_list, user: registred_user) }
  let!(:task_list2) { create(:task_list, user: registred_user2) }
  let!(:task) { create(:task, user: registred_user) }
  let!(:task2) { create(:task, user: registred_user2) }

  describe '#create' do
    let!(:create_task_in_list_params) do
      {
        task_id: task.id,
        task_list_id: task_list.id
      }
    end

    describe 'When data is valid' do
      before do
        post('/task_in_lists',
             params: create_task_in_list_params,
             headers: registred_headers)
      end

      it { expect(response).to have_http_status(:created) }

      it 'contains fields from params' do
        expect(json_response_data['id']).not_to be_nil
        expect(json_response_data['task_id']).to eq(task.id)
        expect(json_response_data['task_list_id']).to eq(task_list.id)
      end
    end

    describe 'When data is NOT valid' do
      before do
        post('/task_in_lists',
             params: {
               task_id: -1,
               task_list_id: -1
             },
             headers: registred_headers)
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe '#update' do
    let!(:task_in_list) { create(:task_in_list, user: registred_user) }

    describe 'When data is true' do
      let!(:update_task_in_list_params) do
        {
          id: task_in_list.id,
          checked: true
        }
      end
      before do
        put("/task_in_lists/#{task_in_list.id}",
            params: update_task_in_list_params,
            headers: registred_headers)
      end

      it { expect(response).to have_http_status(:ok) }

      it 'contains fields from params' do
        expect(json_response_data['id']).not_to be_nil
        expect(json_response_data['checked']).to eq(true)
      end
    end

    describe 'When data is false' do
      let!(:update_invalid_params) do
        {
          id: task_in_list.id,
          checked: false
        }
      end
      before do
        put("/task_in_lists/#{task_in_list.id}",
            params: update_invalid_params,
            headers: registred_headers)
      end

      it { expect(response).to have_http_status(:ok) }

      it 'contains fields from params' do
        expect(json_response_data['id']).not_to be_nil
        expect(json_response_data['checked']).to eq(false)
      end
    end
  end

  describe '#destroy' do
    let!(:task_in_list) { create(:task_in_list) }
    let!(:user) { task_in_list.user }
    let!(:user_headers) { header_for_user(user) }

    describe 'When find task_in_list' do
      before do
        delete("/task_in_lists/#{task_in_list.id}", headers: user_headers)
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    describe 'When NOT find task_in_list' do
      before do
        delete('/task_in_lists/-1', headers: user_headers)
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end
end
