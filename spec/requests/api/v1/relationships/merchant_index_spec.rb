require 'rails_helper'

describe 'Merchant Index Item Relationship' do
  it 'can return all items for merchant' do
    merchant1 = create(:merchant, id: 1)
    merchant2 = create(:merchant, id: 2)

    create(:item, merchant_id: merchant1.id)
    create(:item, merchant_id: merchant1.id)
    create(:item, merchant_id: merchant1.id)
    create(:item, merchant_id: merchant2.id)

    get "/api/v1/merchants/#{merchant1.id}/items"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json[:data].first.count).to eq(3)
  end
end
