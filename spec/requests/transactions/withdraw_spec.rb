require 'rails_helper'

describe TransactionsController, type: :request do
  let!(:asset) { create(:asset, :cash) }
  let!(:user) { create(:user) }

  context 'success' do
    before { user.cash_balance.update(amount: 100) }
    it 'should succesfully purchase' do
      post '/transactions/withdraw',
           headers: authenticated_header(user),
           params:
             {
               transaction:
                 {
                   amount: '10.00'
                 }
             }
      expect(json).to have_key('id')
      expect(json).to have_key('tref')
      expect(json).to have_key('amount')
      expect(json).to have_key('status')
      expect(json).to have_key('asset')
      expect(user.cash_balance.amount.to_f).to eq(90)
    end
  end

  context 'unsuccessful' do
    before { user.cash_balance.update(amount: 0) }
    it 'should be unsuccessful' do
      post '/transactions/withdraw',
           headers: authenticated_header(user),
           params:
             {
               transaction:
                 {
                   amount: '10.00'
                 }
             }
      expect(response.status).to eq(400)
      expect(json['error']['message']['base']).to include('Insufficient funds')
    end
  end
end
