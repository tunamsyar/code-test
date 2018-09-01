FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@surialabs.com" }
    name { Faker::Name }
    password_digest { Faker::Internet.password }
  end
end
