require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:transactions) }
  it { should have_many(:balances) }
  it { should define_enum_for(:country).with(%i[my th]) }

  describe '#create_account_balance' do
    let!(:assets) { create_list(:asset, 3) }
    let!(:user) do
      User.skip_callback(:create, :after, :create_account_balance)
      create(:user)
    end

    before do
      User.set_callback(:create, :after, :create_account_balance)
    end

    subject { user.create_account_balance }

    it 'should create 3 asset balances' do
      subject
      expect(user.balances.count).to eq(3)
      expect(user.balances.map(&:asset)).to match_array(assets)
    end
  end

  describe '#cash_balance' do
    let!(:user) { create(:user, :with_cash_balances) }
    subject { user.cash_balance }

    it do
      should eq(user.balances
                    .where(asset_id: Asset.find_by(asset_type: 'cash')
                    .id).last)
    end
  end

  describe '#asset_balances' do
    let!(:user) { create(:user, :with_asset_balances) }
    subject { user.asset_balances }
    it do
      should eq(user.balances
                    .where
                    .not(asset_id: Asset.find_by(asset_type: 'cash').id))
    end
  end
end
