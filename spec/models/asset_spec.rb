require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:transactions) }
  it { should have_many(:balances) }
end
