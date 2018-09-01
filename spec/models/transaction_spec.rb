require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:asset) }
  it { should define_enum_for(:trx_type).with(%i[buy sell withdraw top_up]) }
  it { should define_enum_for(:status).with(%i[pending success fail]) }

  describe '#process_transaction' do
    let!(:user) { create(:user, :with_cash_balances) }
    let!(:transaction) { create(:transaction, trx_type: 'buy', user: user) }

    subject { transaction.process_transaction }

    it { should be_truthy }

    it 'should update asset balance' do
      subject
      user.balances.reload
      expect(user.balances.last.amount).to eq(transaction.amount)
    end
  end

  describe '#user_cash_balance' do
    context 'cash amount less than trx amount' do
      let!(:user) { create(:user, :with_cash_balances) }
      let!(:transaction) do
        create(:transaction, trx_type: 'buy', user: user, amount: 500)
      end

      before { user.cash_balance.update(amount: 0) }

      subject { transaction.user_cash_balance }

      it { should match_array('Insufficient funds') }
    end
  end

  describe '#user_asset_balance' do
    context 'asset amount less than trx amount' do
      let!(:user) { create(:user, :with_cash_gold_balances) }
      let!(:transaction) do
        create(:transaction, trx_type: 'sell',
                             user: user,
                             amount: 500,
                             asset: Asset.find_by(asset_type: 'gold'))
      end

      before { user.asset_balances.last.update(amount: 0) }

      subject { transaction.user_asset_balance }

      it { should match_array('Insufficient amount to sell') }
    end
  end
end
