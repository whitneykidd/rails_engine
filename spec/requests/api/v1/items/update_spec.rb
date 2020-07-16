require 'rails_helper'

describe 'Item Update' do
  it 'can update a item' do
    item = create(:item)
    updated_item = build(:item, merchant: item.merchant)

    patch "/api/v1/items/#{item.id}", { params: updated_item.attributes }

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json[:data][:type]).to eq('item')
    expect(json[:data][:id]).to eq(item.id.to_s)
    expect(json[:data][:attributes][:name]).to eq(updated_item.name)
    expect(json[:data][:attributes][:description]).to eq(updated_item.description)
    expect(json[:data][:attributes][:unit_price]).to eq(updated_item.unit_price)

    item.reload
    expect(item.name).to eq(updated_item.name)
    expect(item.description).to eq(updated_item.description)
    expect(item.unit_price).to eq(updated_item.unit_price)
  end
end
