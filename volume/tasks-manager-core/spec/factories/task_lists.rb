include ActionDispatch::TestProcess
FactoryBot.define do
  factory :task_list do
    transient do
      user { create(:user) }
    end
    name { Faker::Name.unique.name }
    description { Faker::Lorem.sentence(word_count: 5) }
    frequence_type { TaskList.frequence_types[:daily] }
    user_id { user.id }

    trait :with_tasks do
      transient do
        quantity { 2 }
      end
      task_in_lists { create_list(:task_in_list, quantity, user: user) }
    end
  end
end
