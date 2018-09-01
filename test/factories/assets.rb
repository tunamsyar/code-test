FactoryBot.define do
  factory :asset do
    asset_type { Faker::Coffee.variety }
    value_per_unit { Faker::Number.between(1, 10) }

    trait :gold do
      asset_type { 'gold' }
      value_per_unit { 10 }
    end

    trait :cash do
      asset_type { 'cash' }
      value_per_unit { 1 }
    end
  end
end
