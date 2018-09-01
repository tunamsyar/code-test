module BalanceSerializer
  class Index < ActiveModel::Serializer
    attributes :currency, :balances

    def currency
      return 'MYR' if object.first.user.my?
      'THB'
    end

    def balances
      ActiveModelSerializers::SerializableResource.new(
        object, each_serializer: BalanceSerializer::Base)
    end
  end
end
