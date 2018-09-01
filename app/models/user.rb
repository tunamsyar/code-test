class User < ApplicationRecord
  has_secure_password
  has_many :transactions
  has_many :balances
  enum country: %i[my th]
  enum role: %i[user admin]

  after_create :create_account_balance

  def create_account_balance
    Asset.all.each do |asset|
      balances.create(asset_id: asset.id, amount: 0)
    end
  end

  def cash_balance
    balances.where(asset_id: Asset.find_by(asset_type: 'cash').id).last
  end

  def asset_balances
    balances.where.not(asset_id: Asset.find_by(asset_type: 'cash').id)
  end
end
