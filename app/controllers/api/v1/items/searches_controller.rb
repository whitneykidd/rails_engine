class Api::V1::Items::SearchesController < ApplicationController
  def show
    item = Search.find_by_name(Item, params[:name]).first
    render json: ItemSerializer.new(item).serialized_json
  end

  def index
    items = Search.find_by_name(Item, params[:name])
    render json: ItemSerializer.new(items).serialized_json
  end
end
