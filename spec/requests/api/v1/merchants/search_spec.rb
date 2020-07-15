require 'rails_helper'

describe 'As a user' do
  it 'can find a merchant containing fragment without case sensitivity' do
    merchant1 = create(:merchant, name: 'Turing School')
    merchant2 = create(:merchant, name: 'Not a Match')
    
    get "/api/v1/merchants/find?name=ring"
    json = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful
    expect(json[:data][:type]).to eq('merchant')
    expect(json[:data][:id]).to eq(merchant1.id.to_s)
    expect(json[:data][:attributes][:name]).to eq(merchant1.name)
  end

  it 'can find list of merchants containing fragment without case sensitivity' do
    merchant1 = create(:merchant, name: 'Turing')
    merchant2 = create(:merchant, name: 'Ring World')
    
    get "/api/v1/merchants/find_all?name=ring"
    json = JSON.parse(response.body, symbolize_names: true)
    
    expect(json[:data].length).to eq(2)
    expect(json[:data][0][:type]).to eq('merchant')
    expect(json[:data][0][:attributes][:name]).to eq(merchant1.name)
    
    expect(json[:data][1][:type]).to eq('merchant')
    expect(json[:data][1][:attributes][:name]).to eq(merchant2.name)    
  end
end