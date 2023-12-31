require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { should belong_to(:merchant) }
  it { should belong_to(:customer) }
  it { should have_many(:invoice_items) }
  it { should have_many(:transactions) }
  it { should validate_presence_of(:status) }
end