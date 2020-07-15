class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def self.most_revenue(limit = 10)
    select("merchants.*, \
      SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.where(result: 'success'))
      .group(:id)
      .order('revenue DESC')
      .limit(limit)
  end

  def self.most_items_sold(limit = 10)
    select('merchants.*, SUM(invoice_items.quantity) AS items_sold')
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.where(result: 'success'))
      .group(:id)
      .order('items_sold DESC')
      .limit(limit)
  end
end
