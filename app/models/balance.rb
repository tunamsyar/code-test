class Balance < ApplicationRecord
  belongs_to :user
  belongs_to :asset

  enum currency: %i[myr thb]
end
