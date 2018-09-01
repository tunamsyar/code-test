class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :tref
      t.integer :trx_type
      t.decimal :amount, precision: 8, scale: 2
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
