class TransactionsController < ApplicationController
  before_action :authenticate_user

  def index
    trxs = current_user.transactions
    render json: trxs, each_serializer: TransactionSerializer::Base, status: :ok
  end

  def buy
    trx = current_user.transactions.new(trx_params.merge(trx_type: 'buy'))
    return render_error(trx.errors.messages, :bad_request) unless trx.save
    render json: trx, serializer: TransactionSerializer::Base, status: :created
  end

  def sell
    trx = current_user.transactions.new(trx_params.merge(trx_type: 'sell'))
    return render_error(trx.errors.messages, :bad_request) unless trx.save
    render json: trx, serializer: TransactionSerializer::Base, status: :created
  end

  def withdraw
    trx = current_user.transactions.new(trx_params.merge(trx_type: 'withdraw'))
    return render_error(trx.errors.messages, :bad_request) unless trx.save
    render json: trx, serializer: TransactionSerializer::Base, status: :created
  end

  def top_up
    trx = current_user.transactions.new(trx_params.merge(trx_type: 'top_up'))
    return render_error(trx.errors.messages, :bad_request) unless trx.save
    render json: trx, serializer: TransactionSerializer::Base, status: :created
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
