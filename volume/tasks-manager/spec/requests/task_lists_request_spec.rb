require 'rails_helper'

RSpec.describe 'TaskLists', type: :request do
  let!(:registred_user) { create(:user, :registred) }
  let!(:registred_headers) { header_for_user(registred_user) }

  describe '#create' do
    let!(:task_list) { build(:task_list) }

    let!(:task_list_params) do
      {
        name: task_list.name,
        description: task_list.description,
        frequence_type: task_list.frequence_type,
        user_id: registred_user.id
      }
    end

    describe 'When user is registred' do
      describe 'And data is valid' do
        before do
          post("/users/#{registred_user.id}/task_lists",
               params: task_list_params,
               headers: registred_headers)
        end

        it { expect(response).to have_http_status(:created) }
      end
    end
  end
end
