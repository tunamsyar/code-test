class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :asset
  enum trx_type: %i[buy sell withdraw top_up]
  enum status: %i[pending success fail]
end
