require 'rails_helper'

describe 'Merchant Show Page' do
  it "can get one item by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)
    binding.pry
    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)
  end
end