class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def create
    merchant = Merchant.new(merchant_params)
    render json: MerchantSerializer.new(merchant) if merchant.save
  end

  private

  def merchant_params
    params.permit(:name)
  end
end