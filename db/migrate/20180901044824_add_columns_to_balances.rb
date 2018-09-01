class AddColumnsToBalances < ActiveRecord::Migration[5.2]
  def change
    add_reference :balances, :asset, foreign_key: true
    add_column :balances, :amount, :decimal, precision: 8, scale: 2
    add_column :balances, :currency, :integer
  end
end
