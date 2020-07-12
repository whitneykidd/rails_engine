require 'rails_helper'

describe 'Merchant Index Item Relationship' do
  it 'can return all items for merchant' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    create(:item, merchant_id: merchant1.id)
    create(:item, merchant_id: merchant1.id)
    create(:item, merchant_id: merchant2.id)

    get "/api/v1/merchants/#{merchant1.id}/items"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json[:data][0].count).to eq(2)
  end
end