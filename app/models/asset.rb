class Asset < ApplicationRecord
  has_many :transactions
  has_many :balances

  after_create_commit :add_new_balance_to_user

  def add_new_balance_to_user
    User.all.each do |user|
      user.balances
          .create(asset_id: id,
                  amount: 0,
                  currency: user.my? ? 'myr' : 'thb')
    end
  end
end
