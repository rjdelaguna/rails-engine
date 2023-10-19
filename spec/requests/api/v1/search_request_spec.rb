require "rails_helper"

describe "Search API" do
  describe "Search merchants" do
    before :each do
      @merchant1 = create(:merchant, name: "Steven")
      @merchant2 = create(:merchant, name: "Steve")
      @merchant3 = create(:merchant, name: "John")
    end

    it "returns a single merchant when searched by name" do

      get "/api/v1/merchants/find?name=oh"
  
      merchant = JSON.parse(response.body, symbolize_names: true)[:data]
  
      expect(response).to be_successful
  
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)
  
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to eq("John")
    end

    it "returns all merchants who partially match name search" do

      get "/api/v1/merchants/find_all?name=tev"
  
      merchants = JSON.parse(response.body, symbolize_names: true)[:data]
  
      expect(response).to be_successful

      expect(merchants.count).to eq(2)
      
      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)
        
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end

      expect(merchants[0][:attributes][:name]).to eq("Steve")
      expect(merchants[1][:attributes][:name]).to eq("Steven")
    end
  end

  describe "Search items" do
    before :each do
      @item1 = create(:item, name: "This", unit_price: 2.50)
      @item2 = create(:item, name: "That", unit_price: 3.50)
      @item3 = create(:item, name: "Those", unit_price: 4.50)
      @item4 = create(:item, name: "Stuff", unit_price: 5.50)
    end

    it "returns a single item when searched by name" do

      get "/api/v1/items/find?name=Tuf"

      item = JSON.parse(response.body, symbolize_names: true)[:data]
  
      expect(response).to be_successful
  
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)
  
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to eq("Stuff")

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end

    it "returns a single item when searched with min and max unit pricing" do
      
      get "/api/v1/items/find?min_price=2.75&max_price=5.25"

      item = JSON.parse(response.body, symbolize_names: true)[:data]
  
      expect(response).to be_successful

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)
    
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to eq("That")

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to eq(3.5)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end

    it "returns a single item when searched by min unit pricing" do

      get "/api/v1/items/find?min_price=2.75"

      item = JSON.parse(response.body, symbolize_names: true)[:data]
  
      expect(response).to be_successful

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)
    
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to eq("Stuff")

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to eq(5.5)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end

    it "returns a single item when searched by max unit pricing" do

      get "/api/v1/items/find?max_price=5.25"

      item = JSON.parse(response.body, symbolize_names: true)[:data]
  
      expect(response).to be_successful

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)
    
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to eq("That")

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to eq(3.5)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end

    it "returns all items that partially match name search" do

      get "/api/v1/items/find_all?name=th"

      items = JSON.parse(response.body, symbolize_names: true)[:data]
  
      expect(response).to be_successful

      expect(items.count).to eq(3)

      expect(items[0][:attributes][:name]).to eq("That")
      expect(items[1][:attributes][:name]).to eq("This")
      expect(items[2][:attributes][:name]).to eq("Those")

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

    it "returns all items that match min and max search" do

      get "/api/v1/items/find_all?min_price=2.75&max_price=5.25"

      items = JSON.parse(response.body, symbolize_names: true)[:data]
  
      expect(response).to be_successful

      expect(items.count).to eq(2)

      expect(items[0][:attributes][:name]).to eq("That")
      expect(items[1][:attributes][:name]).to eq("Those")

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

    it "returns all items that match min search" do
      
      get "/api/v1/items/find_all?min_price=2.75"

      items = JSON.parse(response.body, symbolize_names: true)[:data]
  
      expect(response).to be_successful

      expect(items.count).to eq(3)

      expect(items[0][:attributes][:name]).to eq("Stuff")
      expect(items[1][:attributes][:name]).to eq("That")
      expect(items[2][:attributes][:name]).to eq("Those")

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

    it "returns all items that match max search" do

      get "/api/v1/items/find_all?max_price=4.25"

      items = JSON.parse(response.body, symbolize_names: true)[:data]
  
      expect(response).to be_successful

      expect(items.count).to eq(2)

      expect(items[0][:attributes][:name]).to eq("That")
      expect(items[1][:attributes][:name]).to eq("This")

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
  end
end

describe 'sad paths' do
  it "merchants find has no matches" do
    
    get "/api/v1/merchants/find?name=zzz"
  
    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be(nil)

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to eq(nil)
  end

  it "merchants find is not passed a name" do
    
    get "/api/v1/merchants/find?name="
  
    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    data = JSON.parse(response.body, symbolize_names: true)
    
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:code]).to eq(404)
    expect(data[:errors].first[:status]).to eq("NOT FOUND")
  end

  it "items find has no matches" do
    
    get "/api/v1/items/find?name=zzz"
  
    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful

    expect(item).to have_key(:id)
    expect(item[:id]).to be(nil)
      
    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be(nil)

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be(nil)

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be(nil)

    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be(nil)
  end

  it "items find is not passed a name" do
    
    get "/api/v1/merchants/find?name="
  
    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    data = JSON.parse(response.body, symbolize_names: true)
    
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:code]).to eq(404)
    expect(data[:errors].first[:status]).to eq("NOT FOUND")
  end
end