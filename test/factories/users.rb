FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@surialabs.com" }
    name { Faker::Name }
    password_digest { Faker::Internet.password }
    country { 'my' }

    after(:create) do |user|
      create(:asset, :cash)
      user.cash_balance.update(amount: 1000)
    end
  end
end
