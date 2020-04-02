include ActionDispatch::TestProcess
FactoryBot.define do
  factory :task_list do
    name { Faker::Name.unique.name }
    description { Faker::Lorem.sentence(word_count: 5) }
    frequence_type { TaskList.frequence_types[:daily] }
  end
end
