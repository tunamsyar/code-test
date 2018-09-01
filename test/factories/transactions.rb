FactoryBot.define do
  factory :transaction do
    association :asset, factory: :asset
    tref { Faker::Code.npi }
    trx_type{ ['buy', 'withdraw', 'top_up'].sample }
    amount { Faker::Number.decimal(2) }
    status { 'success' }
    user

    after(:build) do |transaction|
      transaction.class.skip_callback(:create, :after, :process_transaction)
    end
    after(:create) do |transaction|
      transaction.class.set_callback(:create, :after, :process_transaction)
    end
  end
end
