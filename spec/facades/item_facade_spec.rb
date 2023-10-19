require 'rails_helper'

RSpec.describe ItemFacade do
  describe "class methods" do
    it "#validate" do
      id = create(:merchant).id

      expect(ItemFacade.validate({item: {merchant_id: id}})).to be true
      expect(ItemFacade.validate({item: {merchant_id: 2}})).to be false
      expect(ItemFacade.validate({item: {}})).to be true
    end

    it "nil_check" do
      item = create(:item)
      expect(ItemFacade.nil_check(nil)).to be_a ItemSerializer
      expect(ItemFacade.nil_check(item)).to be_a ItemSerializer
    end
  end
end