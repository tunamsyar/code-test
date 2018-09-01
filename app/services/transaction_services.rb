class TransactionServices
  def initialize(transaction)
    @transaction = transaction
    @user = transaction.user
    @cash_balance = @user.cash_balance
    @asset_balance = @user.balances.where(asset_id: @transaction.asset.id).last
  end

  def run_transaction
    case @transaction.trx_type
    when 'buy'
      buy_transaction
    when 'sell'
      sell_transaction
    when 'withdraw'
      withdraw_transaction
    else
      top_up_transaction
    end
  end

  def buy_transaction
    new_balance = @cash_balance.amount - @transaction.amount
    new_asset_balance = @asset_balance.amount + @transaction.amount
    update_balances(new_balance, new_asset_balance)
  end

  def sell_transaction
    new_balance = @cash_balance.amount + @transaction.amount
    new_asset_balance = @asset_balance.amount - @transaction.amount
    update_balances(new_balance, new_asset_balance)
  end

  def withdraw_transaction
    new_balance = @cash_balance.amount - @transaction.amount
    update_cash_balances(new_balance)
  end

  def top_up_transaction
    new_balance = @cash_balance.amount + @transaction.amount
    update_cash_balances(new_balance)
  end

  def update_balances(new_balance, new_asset_balance)
    ActiveRecord::Base.transaction do
      @cash_balance.update(amount: new_balance)
      @asset_balance.update(amount: new_asset_balance)
      @transaction.success!
    end
  end

  def update_cash_balances(new_balance)
    ActiveRecord::Base.transaction do
      @cash_balance.update(amount: new_balance)
      @transaction.success!
    end
  end
end
