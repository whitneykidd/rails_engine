require 'rails_helper'

describe 'As a visitor' do
  it 'can get all items' do
    items = create_list(:item, 2)

    get '/api/v1/items'

    json = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful

    expect(json[:data].length).to eq(2)

    expect(json[:data][0][:type]).to eq('item')
    expect(json[:data][0][:id]).to eq(items[0].id.to_s)
    expect(json[:data][0][:attributes][:name]).to eq(items[0].name)
    expect(json[:data][0][:attributes][:description]).to eq(items[0].description)
    expect(json[:data][0][:attributes][:unit_price]).to eq(items[0].unit_price)
    expect(json[:data][0][:attributes][:merchant_id]).to eq(items[0].merchant_id)

    expect(json[:data][1][:type]).to eq('item')
    expect(json[:data][1][:id]).to eq(items[1].id.to_s)
    expect(json[:data][1][:attributes][:name]).to eq(items[1].name)
    expect(json[:data][1][:attributes][:description]).to eq(items[1].description)
    expect(json[:data][1][:attributes][:unit_price]).to eq(items[1].unit_price)
    expect(json[:data][1][:attributes][:merchant_id]).to eq(items[1].merchant_id)
  end
end
