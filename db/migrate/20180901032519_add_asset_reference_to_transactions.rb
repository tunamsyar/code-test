class AddAssetReferenceToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :asset, foreign_key: true
  end
end
