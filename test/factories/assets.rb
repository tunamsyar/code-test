FactoryBot.define do
  factory :asset do
    asset_type { Faker::Coffee.variety }
    value_per_unit { Faker::Number.between(1, 10) }
  end
end
