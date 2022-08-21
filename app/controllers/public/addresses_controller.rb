class Public::AddressesController < ApplicationController

  # admin、customerにログイン前は使えない 先に記載した方のログインページに案内。(cusotomer)
  before_action :authenticate_customer!


  def index
    @address = Address.new
    @addresses = current_customer.addresses.all
  end

  def create
    @address = current_customer.addresses.new(address_params)
    if @address.save
      redirect_to addresses_path
    else
      # gnre#index にrender
      @addresses =  current_customer.addresses.all
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      @addresses = current_customer.addresses.all
      render :index
    end
  end

def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end



private

  def address_params
    params.require(:address).permit( :name, :postal_code, :address)
  end

end
