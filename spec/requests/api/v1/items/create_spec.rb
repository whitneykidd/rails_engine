require 'rails_helper'

describe 'Item Create' do
  it "can create a new item" do
    merchant = create(:merchant)
    item = build(:item, merchant: merchant)

    post "/api/v1/items", params: item.attributes

    json = JSON.parse(response.body, symbolize_names: true)
    last_item = Item.last

    expect(response).to be_successful
    expect(json[:data][:type]).to eq('item')
    expect(json[:data][:attributes][:name]).to eq(item.name)

    expect(last_item.name).to eq(item.name)
  end
end