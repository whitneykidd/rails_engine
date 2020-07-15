require 'rails_helper'

describe 'Item Destroy' do
  it 'can destroy a item' do
    item = create(:item)
    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
