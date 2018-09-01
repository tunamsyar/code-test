FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@mail.com" }
    name { Faker::Name }
    password_digest { Faker::Internet.password }
    country { 'my' }

    trait :with_cash_balances do
      after(:create) do |user|
        create(:asset, :cash)
        user.cash_balance.update(amount: 1000)
      end
    end

    trait :with_cash_gold_balances do
      after(:create) do |user|
        create(:asset, :cash)
        user.cash_balance.update(amount: 1000)
        create(:asset, :gold)
        user.asset_balances.last.update(amount: 1000)
      end
    end

    trait :with_asset_balances do
      after(:create) do |user|
        create(:asset, :cash)
        user.cash_balance.update(amount: 1000)
        create(:asset, :gold)
        create_list(:asset, 3)
        user.asset_balances.each do |asset|
          asset.update(amount: 50, currency: 'myr')
        end
      end
    end
  end
end
