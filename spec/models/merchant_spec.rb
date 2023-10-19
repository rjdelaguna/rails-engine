require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many(:items) }
  it { should have_many(:invoices) }
  it { should validate_presence_of(:name) }

  describe "class methods" do
    it "#find_by_name" do
      merchant1 = create(:merchant, name: "Steven")
      merchant2 = create(:merchant, name: "Steve")
      merchant3 = create(:merchant, name: "SteveO")

      expect(Merchant.find_by_name("tev")).to eq(merchant2)
    end

    it "#find_all_by_name" do
      merchant1 = create(:merchant, name: "Steven")
      merchant2 = create(:merchant, name: "Steve")
      merchant3 = create(:merchant, name: "SteveO")

      expect(Merchant.find_all_by_name("tev")).to eq([merchant2, merchant3, merchant1])
    end
  end
end