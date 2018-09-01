Asset.create(asset_type: 'gold', value_per_unit: 10)
Asset.create(asset_type: 'cash', value_per_unit: 1)

FactoryBot.create_list(:user, 5)

# Admin

User.skip_callback(:create, :after, :create_account_balance)
User.create(email: 'admin@mail.com',
            name: 'Admin',
            role: 'admin',
            password: 'password',
            password_confirmation: 'password')
User.set_callback(:create, :after, :create_account_balance)

User.user.each do |user|
  user.transactions
      .create(tref: SecureRandom.hex(10),
              trx_type: 'top_up',
              amount: 500,
              asset_id: Asset.find_by(asset_type: 'cash').id,
              status: 'success')
end
