require 'rails_helper'

describe TransactionsController, type: :request do
  let!(:user) { create(:user, :with_asset_balances) }
  let!(:transaction) { create(:transaction, user: user) }
  let!(:transaction1) { create(:transaction, user: user) }
  let!(:transaction2) { create(:transaction, user: user) }
  let!(:transaction3) { create(:transaction, user: user) }
  let!(:transaction4) { create(:transaction, user: user) }

  context 'success' do
    it 'should succesfully return list of transactions' do
      get '/transactions', headers: authenticated_header(user)
      expect(json.count).to eq(5)
    end
  end
end
