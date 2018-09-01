require 'rails_helper'

RSpec.describe Balance, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:asset) }
  it { should define_enum_for(:currency).with(%i[myr thb]) }
end
