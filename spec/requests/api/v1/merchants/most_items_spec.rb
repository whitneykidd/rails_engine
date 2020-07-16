require 'rails_helper'

RSpec.describe 'User' do
  it 'can get merchants who have sold the most items' do
    customer = create(:customer)

    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)

    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant2)
    item3 = create(:item, merchant: merchant3)

    invoice1 = create(:invoice, customer: customer, merchant: merchant1)
    invoice2 = create(:invoice, customer: customer, merchant: merchant2)
    invoice3 = create(:invoice, customer: customer, merchant: merchant3)
    invoice4 = create(:invoice, customer: customer, merchant: merchant3)

    create(:invoice_item, item: item1, quantity: 3, unit_price: 1, invoice: invoice1)
    create(:invoice_item, item: item1, quantity: 3, unit_price: 1, invoice: invoice1)

    create(:invoice_item, item: item2, quantity: 2, unit_price: 1, invoice: invoice2)
    create(:invoice_item, item: item2, quantity: 2, unit_price: 1, invoice: invoice2)

    create(:invoice_item, item: item1, quantity: 1, unit_price: 1, invoice: invoice3)
    create(:invoice_item, item: item1, quantity: 1, unit_price: 1, invoice: invoice3)

    create(:transaction, invoice: invoice1, result: 'success')
    create(:transaction, invoice: invoice2, result: 'success')
    create(:transaction, invoice: invoice3, result: 'success')
    create(:transaction, invoice: invoice4, result: 'success')

    get api_v1_merchants_most_items_path(quantity: 2)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].length).to eq(2)

    expect(json[:data][0][:id]).to eq(merchant1.id.to_s)
    expect(json[:data][0][:attributes][:name]).to eq(merchant1.name)

    expect(json[:data][1][:id]).to eq(merchant2.id.to_s)
    expect(json[:data][1][:attributes][:name]).to eq(merchant2.name)
  end
end
