require 'rails_helper'

describe 'As a visitor' do
  it 'can get all merchants' do
    merchants = create_list(:merchant, 3)

    get '/api/v1/merchants'

    json = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    # binding.pry
    expect(json[:data].length).to eq(3)

    expect(json[:data][0][:type]).to eq('merchant')
    expect(json[:data][0][:id]).to eq(merchants[0].id.to_s)
    expect(json[:data][0][:attributes][:name]).to eq(merchants[0].name)

    expect(json[:data][1][:type]).to eq('merchant')
    expect(json[:data][1][:id]).to eq(merchants[1].id.to_s)
    expect(json[:data][1][:attributes][:name]).to eq(merchants[1].name)

    expect(json[:data][2][:type]).to eq('merchant')
    expect(json[:data][2][:id]).to eq(merchants[2].id.to_s)
    expect(json[:data][2][:attributes][:name]).to eq(merchants[2].name)
  end
end
