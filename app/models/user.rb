class User < ApplicationRecord
  has_secure_password
  enum country: %i[my th]
end
