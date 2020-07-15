require 'rails_helper'

describe 'As a user' do
  it 'can find an item containing fragment without case sensitivity' do
    item1 = create(:item, name: 'Ring Pop')
    item2 = create(:item, name: 'Book of Turing')

    get '/api/v1/items/find?name=ring'
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json[:data][:type]).to eq('item')
    expect(json[:data][:id]).to eq(item1.id.to_s)
    expect(json[:data][:attributes][:name]).to eq(item1.name)
  end

  it 'can find list of items containing fragment without case sensitivity' do
    item1 = create(:item, name: 'Ring Pop')
    item2 = create(:item, name: 'Book of Turing')
    item3 = create(:item, name: 'Not a Match')

    get '/api/v1/items/find_all?name=ring'
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].length).to eq(2)
    expect(json[:data][0][:type]).to eq('item')
    expect(json[:data][0][:attributes][:name]).to eq(item1.name)
    expect(json[:data][0][:attributes][:description]).to eq(item1.description)

    expect(json[:data][1][:type]).to eq('item')
    expect(json[:data][1][:id]).to eq(item2.id.to_s)
    expect(json[:data][1][:attributes][:name]).to eq(item2.name)
    expect(json[:data][1][:attributes][:description]).to eq(item2.description)
  end
end
