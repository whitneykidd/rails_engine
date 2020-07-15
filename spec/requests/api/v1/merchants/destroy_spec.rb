require 'rails_helper'

describe 'Merchant Destroy' do
  it 'can destroy a merchant' do
    merchant = create(:merchant)
    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect { Merchant.find(merchant.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
