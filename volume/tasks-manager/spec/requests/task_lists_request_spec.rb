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

    describe 'When user is registred' do
      describe 'And TaskList belongs to him' do
        describe 'And data is valid' do
          before do
            post("/users/#{registred_user.id}/task_lists",
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

        describe 'And data is NOT valid' do
          before do
            post("/users/#{registred_user.id}/task_lists",
                 params: {},
                 headers: registred_headers)
          end

          it { expect(response).to have_http_status(:unprocessable_entity) }

          it 'contains error response' do
            expect(json_response_error).to eq("Validation failed: Name can't be blank, Frequence type can't be blank")
          end
        end
      end

      describe 'And TaskList belongs to another user' do
        before do
          post("/users/#{registred_user2.id}/task_lists",
               params: create_task_list_params,
               headers: registred_headers)
        end

        it { expect(response).to have_http_status(:unauthorized) }
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

      describe 'And TaskList belongs to him' do
        describe 'And data is valid' do
          before do
            put("/users/#{registred_user.id}/task_lists/#{task_list.id}",
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
            put("/users/#{registred_user.id}/task_lists/#{task_list.id}",
                params: { name: '' },
                headers: registred_headers)
          end

          it { expect(response).to have_http_status(:unprocessable_entity) }

          it 'contains updated fields from params' do
            expect(json_response_error).to eq("Validation failed: Name can't be blank")
          end
        end
      end

      describe 'And TaskList belongs to another user' do
        before do
          put("/users/#{registred_user2.id}/task_lists/#{task_list.id}",
              params: update_task_list_params,
              headers: registred_headers2)
        end

        it { expect(response).to have_http_status(:unauthorized) }
      end
    end
  end

  describe '#destroy' do
    let!(:task_list) { create(:task_list, user: registred_user) }

    describe 'When user is registred' do
      describe 'And TaskList belongs to him' do
        describe 'And it is found' do
          before do
            delete("/users/#{registred_user.id}/task_lists/#{task_list.id}",
                   headers: registred_headers)
          end

          it { expect(response).to have_http_status(:no_content) }
        end

        describe 'And it is NOT found' do
          before do
            delete("/users/#{registred_user.id}/task_lists/-1",
                   headers: registred_headers)
          end

          it { expect(response).to have_http_status(:not_found) }

          it 'contains updated fields from params' do
            expect(json_response_error).to eq("Couldn't find TaskList")
          end
        end
      end

      describe 'And TaskList belongs to another user' do
        before do
          delete("/users/#{registred_user2.id}/task_lists/#{task_list.id}",
                 headers: registred_headers2)
        end

        it { expect(response).to have_http_status(:unauthorized) }
      end
    end
  end

  describe '#list' do
    describe 'When user is registred' do
      let!(:task_list_list) { create_list(:task_list, 10, user: registred_user) }
      let!(:task_list_list2) { create_list(:task_list, 20) }

      before do
        get("/users/#{registred_user.id}/task_lists",
            headers: registred_headers)
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json_response_data.length).to eq(task_list_list.length) }
    end
  end
end
