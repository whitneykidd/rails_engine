require 'rails_helper'

describe 'As a user' do
  it 'can return the total revenue across all merchants between given dates' do
    customer = create(:customer)

    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)

    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant2)
    item3 = create(:item, merchant: merchant3)
    item4 = create(:item, merchant: merchant3)

    invoice1 = create(:invoice, customer: customer, merchant: merchant1, created_at: '2020-07-01')
    invoice2 = create(:invoice, customer: customer, merchant: merchant1, created_at: '2020-07-02')
    invoice3 = create(:invoice, customer: customer, merchant: merchant2, created_at: '2020-07-02')
    invoice4 = create(:invoice, customer: customer, merchant: merchant3, created_at: '2020-07-03')

    create(:invoice_item, item: item1, quantity: 1, unit_price: 1, invoice: invoice1)
    create(:invoice_item, item: item2, quantity: 2, unit_price: 1, invoice: invoice2)
    create(:invoice_item, item: item3, quantity: 2, unit_price: 1, invoice: invoice2)
    create(:invoice_item, item: item4, quantity: 3, unit_price: 1, invoice: invoice3)
    create(:invoice_item, item: item4, quantity: 3, unit_price: 1, invoice: invoice3)
    create(:invoice_item, item: item4, quantity: 5, unit_price: 1, invoice: invoice4)

    create(:transaction, invoice: invoice1, result:'success')
    create(:transaction, invoice: invoice2, result:'success')
    create(:transaction, invoice: invoice3, result:'success')
    create(:transaction, invoice: invoice4, result:'failed')

    get api_v1_revenue_path(start: '2020-07-02', end: '2020-07-03')

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:attributes]).to eq("11.0")
  end
end