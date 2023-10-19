class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items

  validates_presence_of :name, :description, :unit_price

  def self.find_by_name(name)
    Item.where("name ILIKE ?", "%#{name}%").order("name ASC").first
  end
  
  def self.find_by_max_min(max, min)
    Item.where("unit_price >= ? AND unit_price <= ?", min, max).order("name ASC").first
  end
  
  def self.find_by_max(max)
    Item.where("unit_price <= ?", max).order("name ASC").first
  end
  
  def self.find_by_min(min)
    Item.where("unit_price >= ?", min).order("name ASC").first
  end

  def self.find_all_by_name(name)
    Item.where("name ILIKE ?", "%#{name}%").order("name ASC")
  end

  def self.find_all_by_max_min(max, min)
    Item.where("unit_price >= ? AND unit_price <= ?", min, max).order("name ASC")
  end

  def self.find_all_by_max(max)
    Item.where("unit_price <= ?", max).order("name ASC")
  end

  def self.find_all_by_min(min)
    Item.where("unit_price >= ?", min).order("name ASC")
  end
end