require 'rails_helper'

RSpec.describe 'TaskLists', type: :request do
  let!(:registred_user) { create(:user, :registred) }
  let!(:registred_user2) { create(:user, :registred) }
  let!(:registred_headers) { header_for_user(registred_user) }

  describe '#create' do
    let!(:task_list) { build(:task_list) }

    let!(:task_list_params) do
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
                 params: task_list_params,
                 headers: registred_headers)
          end

          it { expect(response).to have_http_status(:created) }

          it 'contains fields from params' do
            expect(json_response_data['id']).not_to be_nil
            expect(json_response_data['name']).to eq(task_list_params[:name])
            expect(json_response_data['description']).to eq(task_list_params[:description])
            expect(json_response_data['frequence_type']).to eq(task_list_params[:frequence_type])
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
               params: task_list_params,
               headers: registred_headers)
        end

        it { expect(response).to have_http_status(:unauthorized) }
      end
    end
  end
end
