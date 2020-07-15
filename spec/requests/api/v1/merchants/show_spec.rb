require 'rails_helper'

describe 'Merchant Show Page' do
  it 'can get one merchant by its id' do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(json[:data][:type]).to eq('merchant')
    expect(json[:data][:id]).to eq(merchant.id.to_s)
    expect(json[:data][:attributes][:name]).to eq(merchant.name)
  end
end
