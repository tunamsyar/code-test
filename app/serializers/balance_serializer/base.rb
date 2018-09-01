module BalanceSerializer
  class Base < ActiveModel::Serializer
    attributes :amount, :asset

    def asset
      object.asset.asset_type
    end
  end
end
