require 'rails_helper'

describe TransactionsController, type: :request do
  let!(:asset) { create(:asset, :cash) }
  let!(:user) { create(:user) }

  context 'success' do
    before { user.cash_balance.update(amount: 0) }
    it 'should succesfully top up' do
      post '/transactions/top_up',
           headers: authenticated_header(user),
           params:
             {
               transaction:
                 {
                   amount: '100.00'
                 }
             }
      expect(json).to have_key('id')
      expect(json).to have_key('tref')
      expect(json).to have_key('amount')
      expect(json).to have_key('status')
      expect(json).to have_key('asset')
      expect(user.cash_balance.amount.to_f).to eq(100)
    end
  end
end
