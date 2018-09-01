module TransactionSerializer
  class Base < ActiveModel::Serializer
    attributes :id, :tref, :trx_type, :amount, :asset, :status

    def asset
      object.asset.asset_type
    end
  end
end
