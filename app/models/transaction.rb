class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :asset
  enum trx_type: %i[buy sell withdraw top_up]
  enum status: %i[pending success fail]

  after_create :process_transaction

  validate :user_cash_balance, if: -> { buy? || withdraw? }, on: :create
  validate :user_asset_balance, if: :sell?, on: :create

  def process_transaction
    TransactionServices.new(self).run_transaction
  end

  def user_cash_balance
    return if user.cash_balance.amount > amount
    errors.add(:base, 'Insufficient funds')
  end

  def user_asset_balance
    return if user.balances.find_by(asset_id: asset_id).amount > amount
    errors.add(:base, 'Insufficient amount to sell')
  end
end
