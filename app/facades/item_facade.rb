class ItemFacade

  def self.validate(params)
    if params[:item][:merchant_id] != nil
      ItemPoro.new(params[:item]).validate
    else
      true
    end
  end

  def self.nil_check(response)
    if response == nil
      ItemSerializer.new(ItemPoro.new)
    else
      ItemSerializer.new(response)
    end
  end

end