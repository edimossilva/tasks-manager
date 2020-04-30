require 'rails_helper'

RSpec.describe 'TaskWithTaskLists', type: :request do
  let!(:registred_user) { create(:user, :registred) }
  let!(:registred_headers) { header_for_user(registred_user) }

  let!(:task) { build(:task, user: registred_user) }
  let!(:task_list) { create(:task_list, user: registred_user) }
  let!(:create_task_params) do
    {
      name: task.name,
      description: task.description,
      task_list_id: task_list.id
    }
  end

  describe 'create' do
    context 'When data is valid' do
      context 'when task doesnt exists' do
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

        it 'create a new task' do
          task_id = json_response_data['id']
          expect(task_id).not_to be_nil
        end
      end

      context 'when task exists' do
        context 'When task is NOT in task_list' do
          let!(:task) { create(:task, user: registred_user) }
          let!(:task_list) { create(:task_list, user: registred_user) }
          let!(:create_task_params) do
            {
              name: task.name,
              description: task.description,
              task_list_id: task_list.id
            }
          end
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

          it 'associate to a existing task' do
            task_id = json_response_data['id']
            expect(task_id).to eq(task.id)
          end
        end
        context 'When task is in task_list' do
          let!(:task_in_list) { create(:task_in_list, user: registred_user) }
          let!(:task_list) { task_in_list.task_list }
          let!(:create_task_params) do
            {
              name: task_in_list.task.name,
              description: task_in_list.task.description,
              task_list_id: task_list.id
            }
          end
          before do
            post('/task_with_task_list',
                 params: create_task_params,
                 headers: registred_headers)
          end

          it { expect(response).to have_http_status(:unprocessable_entity) }
        end
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
