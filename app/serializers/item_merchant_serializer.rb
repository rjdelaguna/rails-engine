class ItemMerchantSerializer
  include JSONAPI::Serializer
  attributes :name
  set_type :merchant
end