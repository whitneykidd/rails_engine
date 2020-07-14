FactoryBot.define do
  factory :invoice_item do
    quantity { rand(9) }
    unit_price { rand(999).fdiv(100) }
    item
    invoice
  end
end