class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :asset
  enum trx_type: %i[buy sell withdraw top_up]
  enum status: %i[pending success fail]

  after_create :process_transaction

  validate :user_cash_balance, if: :buy?

  def process_transaction
    TransactionServices.new(self).run_transaction
  end

  def user_cash_balance
    return if user.cash_balance.amount > amount
    false
  end
end
