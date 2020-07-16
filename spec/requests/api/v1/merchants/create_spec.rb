require 'rails_helper'

describe 'Merchant Create' do
  it 'can create a new merchant' do
    merchant = build(:merchant)

    post '/api/v1/merchants', params: { name: merchant.name }

    json = JSON.parse(response.body, symbolize_names: true)
    last_merchant = Merchant.last

    expect(response).to be_successful
    expect(json[:data][:type]).to eq('merchant')
    expect(json[:data][:attributes][:name]).to eq(merchant.name)

    expect(last_merchant.name).to eq(merchant.name)
  end
end
