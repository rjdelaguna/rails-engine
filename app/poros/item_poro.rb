class ItemPoro
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id
  def initialize(params = {id: nil, description: nil, unit_price: nil, merchant_id: nil})
    @id = params[:id]
    @name = params[:name]
    @description = params[:description]
    @unit_price = params[:unit_price]
    @merchant_id = params[:merchant_id]
  end

  def validate
    Merchant.exists?(id: @merchant_id)
  end
end