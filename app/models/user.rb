class User < ApplicationRecord
  has_secure_password
  has_many :transactions
  has_many :balances
  enum country: %i[my th]
end
