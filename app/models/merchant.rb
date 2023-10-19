class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  validates_presence_of :name

  def self.find_by_name(name)
    Merchant.where("name ILIKE ?", "%#{name}%").order("name ASC").first
  end

  def self.find_all_by_name(name)
    Merchant.where("name ILIKE ?", "%#{name}%").order("name ASC")
  end
end