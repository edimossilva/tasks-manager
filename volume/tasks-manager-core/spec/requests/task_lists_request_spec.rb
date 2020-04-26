require 'rails_helper'

RSpec.describe 'TaskLists', type: :request do
  let!(:registred_user) { create(:user, :registred) }
  let!(:registred_user2) { create(:user, :registred) }
  let!(:registred_headers) { header_for_user(registred_user) }
  let!(:registred_headers2) { header_for_user(registred_user2) }

  describe '#create' do
    let!(:task_list) { build(:task_list) }

    let!(:create_task_list_params) do
      {
        name: task_list.name,
        description: task_list.description,
        frequence_type: task_list.frequence_type
      }
    end

    describe 'When data is valid' do
      before do
        post('/task_lists',
             params: create_task_list_params,
             headers: registred_headers)
      end

      it { expect(response).to have_http_status(:created) }

      it 'contains fields from params' do
        expect(json_response_data['id']).not_to be_nil
        expect(json_response_data['name']).to eq(create_task_list_params[:name])
        expect(json_response_data['description']).to eq(create_task_list_params[:description])
        expect(json_response_data['frequence_type']).to eq(create_task_list_params[:frequence_type])
        expect(json_response_data['user_id']).to eq(registred_user.id)
      end
    end

    describe 'When data is NOT valid' do
      describe 'And params are empty' do
        before do
          post('/task_lists',
               params: {},
               headers: registred_headers)
        end

        it { expect(response).to have_http_status(:unprocessable_entity) }

        it 'contains error response' do
          expect(json_response_error).to eq("Validation failed: Name can't be blank, Frequence type can't be blank")
        end
      end

      describe 'And frequency_type is invalid' do
        let!(:invalid_frequency_task_list_params) do
          {
            name: Faker::Name.unique.name,
            description: Faker::Lorem.sentence(word_count: 5),
            frequence_type: 1
          }
        end
        before do
          post('/task_lists',
               params: invalid_frequency_task_list_params,
               headers: registred_headers)
        end
        it { expect(response).to have_http_status(:unprocessable_entity) }
        it 'contains error response' do
          expect(json_response_error).to eq("'1' is not a valid frequence_type")
        end
      end
    end
  end

  describe '#destroy' do
    let!(:task_list) { create(:task_list, user: registred_user) }

    describe 'And it is found' do
      before do
        delete("/task_lists/#{task_list.id}",
               headers: registred_headers)
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    describe 'And it is NOT found' do
      before do
        delete('/task_lists/-1',
               headers: registred_headers)
      end

      it { expect(response).to have_http_status(:not_found) }

      it 'contains updated fields from params' do
        expect(json_response_error).to eq("Couldn't find TaskList")
      end
    end
  end

  describe '#edit' do
    let!(:updated_name) { 'Updated name' }

    let!(:update_task_list_params) do
      {
        name: updated_name
      }
    end

    describe 'When user is registred' do
      let!(:task_list) { create(:task_list, user: registred_user) }

      describe 'And data is valid' do
        before do
          put("/task_lists/#{task_list.id}",
              params: update_task_list_params,
              headers: registred_headers)
        end

        it { expect(response).to have_http_status(:ok) }

        it 'contains updated fields from params' do
          expect(json_response_data['name']).to eq(updated_name)
        end
      end

      describe 'And data is NOT valid' do
        before do
          put("/task_lists/#{task_list.id}",
              params: { name: '' },
              headers: registred_headers)
        end

        it { expect(response).to have_http_status(:unprocessable_entity) }

        it 'contains updated fields from params' do
          expect(json_response_error).to eq("Validation failed: Name can't be blank")
        end
      end
    end
  end

  describe '#index' do
    let!(:task_list_list) { create_list(:task_list, 10, user: registred_user) }
    let!(:task_list_list2) { create_list(:task_list, 20) }

    before do
      get('/task_lists',
          headers: registred_headers)
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json_response_data.length).to eq(task_list_list.length) }
  end

  describe '#show' do
    let!(:updated_name) { 'Updated name' }

    let!(:update_task_list_params) do
      {
        name: updated_name
      }
    end

    describe 'When user is registred' do
      let!(:task_list) { create(:task_list, :with_tasks, quantity: 3, user: registred_user) }

      describe 'And TaskList is Found' do
        before do
          get("/task_lists/#{task_list.id}",
              headers: registred_headers)
        end

        it { expect(response).to have_http_status(:ok) }

        it 'contains fields' do
          expect(json_response_data['id']).to eq(task_list.id)
          expect(json_response_data['name']).to eq(task_list[:name])
          expect(json_response_data['description']).to eq(task_list[:description])
          expect(json_response_data['frequence_type']).to eq(task_list[:frequence_type])
          expect(json_response_data['user_id']).to eq(registred_user.id)
        end

        it 'contains task_in_lists' do
          expect(json_response_data['task_in_lists']).to_not be_nil
          expect(json_response_data['task_in_lists'].count).to eq(3)
        end

        it 'task_in_list is properly formatted' do
          json_task_in_list = json_response_data['task_in_lists'].first
          task_in_list = task_list.task_in_lists.first

          expect(json_task_in_list['id']).to eq(task_in_list.id)
          expect(json_task_in_list['checked']).to eq(task_in_list.checked)
        end

        it 'task_in_list.task is properly formatted' do
          json_task = json_response_data['task_in_lists'].first['task']
          task = task_list.task_in_lists.first.task

          expect(json_task['id']).to eq(task.id)
          expect(json_task['name']).to eq(task.name)
          expect(json_task['description']).to eq(task.description)
          expect(json_task['user_id']).to eq(task.user_id)
        end
      end

      describe 'And TaskList is not found' do
        before do
          get('/task_lists/-1',
              headers: registred_headers)
        end

        it { expect(response).to have_http_status(:not_found) }
      end
    end
  end
end
