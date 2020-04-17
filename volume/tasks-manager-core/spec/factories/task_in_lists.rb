include ActionDispatch::TestProcess
FactoryBot.define do
  factory :task_in_list do
    transient do
      user { create(:user) }
    end

    task_id { create(:task, user_id: user.id).id }
    task_list_id { create(:task_list, user_id: user.id).id }
    checked { true }
  end
end
