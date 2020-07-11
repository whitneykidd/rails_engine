require 'rails_helper'

describe 'Item Show' do
  it "can get one item by its id" do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
       
    expect(json[:data][:type]).to eq('item')
    expect(json[:data][:id]).to eq(item.id.to_s)
    expect(json[:data][:attributes][:name]).to eq(item.name)
    expect(json[:data][:attributes][:description]).to eq(item.description)
    expect(json[:data][:attributes][:unit_price]).to eq(item.unit_price)
    expect(json[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
  end
end