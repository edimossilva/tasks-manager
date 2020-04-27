require 'rails_helper'

RSpec.describe 'TaskLists', type: :request do
  let!(:registred_user) { create(:user, :registred) }
  let!(:registred_user2) { create(:user, :registred) }
  let!(:registred_headers) { header_for_user(registred_user) }
  let!(:registred_headers2) { header_for_user(registred_user2) }
  let!(:task_list) { create(:task_list) }

  context '#create' do
    let!(:task) { build(:task) }

    let!(:create_task_params) do
      {
        name: task.name,
        description: task.description
      }
    end

    context 'When data is valid' do
      before do
        post('/tasks',
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
    end

    context 'When data is NOT valid, name is empty' do
      before do
        post('/tasks',
             params: { name: '' },
             headers: registred_headers)
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  context '#update' do
    let!(:task) { create(:task, user: registred_user) }
    let!(:updated_name) { 'updated_name' }

    context 'When data is valid' do
      before do
        put("/tasks/#{task.id}",
            params: { name: updated_name },
            headers: registred_headers)
      end

      it { expect(response).to have_http_status(:ok) }

      it 'contains updated field' do
        expect(json_response_data['name']).to eq(updated_name)
      end
    end

    context 'When data is NOT valid, name is empty' do
      before do
        put("/tasks/#{task.id}",
            params: { name: '' },
            headers: registred_headers)
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'When task is NOT found' do
      before do
        put('/tasks/-1',
            headers: registred_headers)
      end

      it { expect(response).to have_http_status(:not_found) }
    end

    context 'When user is NOT task owner' do
      before do
        put("/tasks/#{task.id}",
            headers: registred_headers2)
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end

  context '#destroy' do
    let!(:task) { create(:task, user: registred_user) }
    let!(:updated_name) { 'updated_name' }

    context 'When task is found' do
      before do
        delete("/tasks/#{task.id}",
               headers: registred_headers)
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'When task is NOT found' do
      before do
        delete('/tasks/-1',
               headers: registred_headers)
      end

      it { expect(response).to have_http_status(:not_found) }
    end

    context 'When user is NOT task owner' do
      before do
        delete("/tasks/#{task.id}",
               headers: registred_headers2)
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
