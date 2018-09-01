class TransactionsController < ApplicationController
  before_action :authenticate_user

  def index
    trxs = current_user.transactions
    render json: trxs, status: :ok
  end

  def buy
    trx = current_user.transactions.new(trx_params.merge(trx_type: 'buy'))
    render json: trx, status: :created if trx.save
  end

  def sell
    trx = current_user.transactions.new(trx_params.merge(trx_type: 'sell'))
    render json: trx, status: :created if trx.save
  end

  def withdraw
    trx = current_user.transactions.new(trx_params.merge(trx_type: 'withdraw'))
    render json: trx, status: :created if trx.save
  end

  def top_up
    trx = current_user.transactions.new(trx_params.merge(trx_type: 'top_up'))
    render json: trx, status: :created if trx.save
  end

  private

  def trx_params
    params.require(:transaction)
          .permit(:amount)
          .merge(asset_id: asset_param, tref: SecureRandom.hex(10))
  end

  def asset_param
    return Asset.find_by(asset_type: 'cash').id unless params[:transaction][:asset]
    Asset.find_by(asset_type: params[:transaction][:asset]).id
  end
end
