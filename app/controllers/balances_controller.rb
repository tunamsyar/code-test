class BalancesController < ApplicationController
  before_action :authenticate_user

  def index
    balances = current_user.balances
    render json: balances, serializer: BalanceSerializer::Index
  end
end
