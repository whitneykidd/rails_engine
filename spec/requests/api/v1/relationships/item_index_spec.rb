require 'rails_helper'

describe 'Item Index Merchant Relationship' do
  it 'can return the merchant for an item' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    item = create(:item, merchant_id: merchant1.id)

    get "/api/v1/items/#{item.id}/merchant"
    
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(item.merchant_id).to eq(merchant1.id)
  end
end