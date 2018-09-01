require 'rails_helper'

describe TransactionsController, type: :request do
  let!(:asset) { create(:asset, asset_type: 'cash') }
  let!(:asset1) { create(:asset, asset_type: 'gold') }
  let!(:user) { create(:user) }
  before do
    user.cash_balance.update(amount: 100)
    user.asset_balances.last.update(amount: 10)
  end

  it '' do
    post '/transactions/buy',
         headers: authenticated_header(user),
         params:
           {
             transaction:
               {
                 asset: 'gold',
                 amount: '10.00'
               }
           }
  end
end
