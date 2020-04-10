include ActionDispatch::TestProcess
FactoryBot.define do
  factory :user do
    username { Faker::Name.unique.name }
    password { Faker::String.random(length: 3) }

    trait :without_username do
      username { nil }
    end

    trait :without_password do
      password { nil }
    end

    trait :user_with_invalid_password do
      password { Faker::String.random(length: 2) }
    end
  end
end
