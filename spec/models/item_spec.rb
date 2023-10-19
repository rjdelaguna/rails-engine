require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to(:merchant) }
  it { should have_many(:invoice_items) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:unit_price) }

  describe "class methods" do
    before :each do
      @item1 = create(:item, name: "Thing B", unit_price: 2.50)
      @item2 = create(:item, name: "Thing A", unit_price: 3.25)
      @item3 = create(:item, name: "Thing C", unit_price: 4.15)
    end

    it "#find_by_name" do
      expect(Item.find_by_name("ing")).to eq(@item2)
    end
    
    it "#find_by_max_min" do
      expect(Item.find_by_max_min(4.15, 2.50)).to eq(@item2)
    end
    
    it "#find_by_max" do
      expect(Item.find_by_max(3.10)).to eq(@item1)
    end
    
    it "#find_by_min" do
      expect(Item.find_by_min(3.30)).to eq(@item3)
    end
    
    it "#find_all_by_name" do
      expect(Item.find_all_by_name("ing")).to eq([@item2, @item1, @item3])
    end
    
    it "#find_all_by_max_min" do
      expect(Item.find_all_by_max_min(4.15, 2.75)).to eq([@item2, @item3])
    end
    
    it "#find_all_by_max" do
      expect(Item.find_all_by_max(3.80)).to eq([@item2, @item1])
    end
    
    it "#find_all_by_min" do
      expect(Item.find_all_by_min(1.80)).to eq([@item2, @item1, @item3])
    end
  end
end