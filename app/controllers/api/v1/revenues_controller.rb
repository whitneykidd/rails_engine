class Api::V1::RevenuesController < ApplicationController
  def index
    revenue = Revenue.total_between_dates(params[:start], params[:end])
    render json: RevenueSerializer.new(revenue)
  end
end
