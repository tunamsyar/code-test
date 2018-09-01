require 'rails_helper'

describe TransactionsController, type: :request do
  let!(:user) { create(:user, :with_cash_gold_balances) }

  context 'success' do
    before do
      user.cash_balance.update(amount: 0)
      user.asset_balances.last.update(amount: 20)
    end
    it 'should succesfully purchase' do
      post '/transactions/sell',
           headers: authenticated_header(user),
           params:
             {
               transaction:
                 {
                   asset: 'gold',
                   amount: '10.00'
                 }
             }

      expect(json).to have_key('id')
      expect(json).to have_key('tref')
      expect(json).to have_key('amount')
      expect(json).to have_key('status')
      expect(json).to have_key('asset')
      expect(user.asset_balances.last.amount.to_f).to eq(10)
      expect(user.cash_balance.amount.to_f).to eq(10)
    end
  end

  context 'unsuccessful' do
    before { user.asset_balances.last.update(amount: 0) }
    it 'should be unsuccessful' do
      post '/transactions/sell',
           headers: authenticated_header(user),
           params:
             {
               transaction:
                 {
                   asset: 'gold',
                   amount: '10.00'
                 }
             }
      expect(response.status).to eq(400)
      expect(json['error']['message']['base'])
        .to include('Insufficient amount to sell')
    end
  end
end
