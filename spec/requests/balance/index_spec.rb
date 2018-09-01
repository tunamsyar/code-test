require 'rails_helper'

describe BalancesController, type: :request do
  let!(:user) { create(:user, :with_asset_balances) }
  it 'should return a list of asset balances' do
    get '/balances', headers: authenticated_header(user)
    expect(json['balances'].count).to eq(5)
    expect(json['currency']).to eq('MYR')
    expect(json['balances'].map { |j| j['asset'] }).to include('gold')
    expect(json['balances'].map { |j| j['asset'] }).to include('cash')
  end
end
