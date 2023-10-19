require "rails_helper"

describe "Merchant Items API" do
  it "sends a list of a merchant's items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  it "returns an items merchant" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)
    
    get "/api/v1/items/#{Item.last.id}/merchant"

    expect(response).to be_successful

    found_merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(found_merchant).to have_key(:id)
    expect(found_merchant[:id]).to be_an(String)

    expect(found_merchant[:attributes]).to have_key(:name)
    expect(found_merchant[:attributes][:name]).to be_a(String)
    expect(found_merchant[:attributes][:name]).to eq(merchant.name)
  end
end