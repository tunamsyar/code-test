require 'rails_helper'

describe TransactionsController, type: :request do
  let!(:user) { create(:user) }
  let!(:asset) { create(:asset, asset_type: 'cash') }
  it '' do
    post '/transactions/top_up',
         headers: authenticated_header(user),
         params:
           {
             transaction:
               {
                 amount: '10.00'
               }
           }
  end
end
