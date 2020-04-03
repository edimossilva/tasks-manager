include ActionDispatch::TestProcess
FactoryBot.define do
  factory :task do
    name { Faker::Name.unique.name }
    description { Faker::Lorem.sentence(word_count: 5) }
    user_id { create(:user).id }
  end
end
