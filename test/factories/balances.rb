FactoryBot.define do
  factory :balance do
    association :asset, factory: :asset
  end
end
