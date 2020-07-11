require 'rails_helper'

describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items}
    it { should have_many :invoices}
    it { should have_many :invoice_items}
    it { should have_many :transactions}
  end

  describe 'validations' do
    it { should validate_presence_of :name}
  end
end