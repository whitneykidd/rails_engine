require 'rails_helper'

describe 'As a user' do
  it 'can return merchants with most revenue' do
  customer = create(:customer)

    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)

    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant2)
    item3 = create(:item, merchant: merchant3)
    item4 = create(:item, merchant: merchant3)

    invoice1 = create(:invoice, customer: customer, merchant: merchant1)
    invoice2 = create(:invoice, customer: customer, merchant: merchant2)
    invoice3 = create(:invoice, customer: customer, merchant: merchant3)
    invoice4 = create(:invoice, customer: customer, merchant: merchant3)
    invoice5 = create(:invoice, customer: customer, merchant: merchant3)

    create(:invoice_item, item: item1, quantity: 3, unit_price: 1, invoice: invoice1)
    create(:invoice_item, item: item2, quantity: 1, unit_price: 1, invoice: invoice2)
    create(:invoice_item, item: item2, quantity: 2, unit_price: 1, invoice: invoice3)
    create(:invoice_item, item: item3, quantity: 3, unit_price: 1, invoice: invoice3)
    create(:invoice_item, item: item3, quantity: 1, unit_price: 1, invoice: invoice4)
    create(:invoice_item, item: item3, quantity: 4, unit_price: 1, invoice: invoice4)
    create(:invoice_item, item: item4, quantity: 1, unit_price: 1, invoice: invoice4)
    create(:invoice_item, item: item4, quantity: 2, unit_price: 1, invoice: invoice5)

    create(:transaction, invoice: invoice1, result: 'failed')
    create(:transaction, invoice: invoice2, result: 'success')
    create(:transaction, invoice: invoice3, result: 'success')
    create(:transaction, invoice: invoice4, result: 'success')
    create(:transaction, invoice: invoice5, result: 'success')
    create(:transaction, invoice: invoice1, result: 'success')

    get '/api/v1/merchants/most_revenue?quantity=2'

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].length).to eq(2)

    expect(json[:data][0][:id]).to eq(merchant3.id.to_s)
    expect(json[:data][0][:attributes][:name]).to eq(merchant3.name)

    expect(json[:data][1][:id]).to eq(merchant1.id.to_s)
    expect(json[:data][1][:attributes][:name]).to eq(merchant1.name)
  end
end