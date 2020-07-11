require 'rails_helper'

describe 'Merchant Update' do
  it "can update a merchant" do
    merchant = create(:merchant)
    updated_merchant = build(:merchant)

    put "/api/v1/merchants/#{merchant.id}", { params: updated_merchant.attributes }

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json[:data][:type]).to eq('merchant')
    expect(json[:data][:id]).to eq(merchant.id.to_s)
    expect(json[:data][:attributes][:name]).to eq(updated_merchant.name)

    merchant.reload
    expect(merchant.name).to eq(updated_merchant.name)
  end
end