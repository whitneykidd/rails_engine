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

  def update
    merchant = Merchant.update(params[:id], merchant_params)
    render json: MerchantSerializer.new(merchant)
  end

  def destroy
    merchant = Merchant.destroy(params[:id])
    render json: MerchantSerializer.new(merchant)
  end

  private

  def merchant_params
    params.permit(:name)
  end
end