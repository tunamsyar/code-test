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

    trait :with_asset_balances do
      after(:create) do |user|
        create(:asset, :gold)
        create_list(:asset, 3)
        user.asset_balances.each do |asset|
          asset.update(amount: 50, currency: 'myr')
        end
      end
    end
  end
end
