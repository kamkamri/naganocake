class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = current_customer.addresses.all
  end

  def create
    @address = current_customer.addresses.new(address_params)
    if @address.save
      flash[:notice] = "You have created address successfully."
      # indexにリダイレクト
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
      flash[:notice] = "You have address item successfully."
      # item#showにリダイレクト
      redirect_to addresses_path
    else
      @addresses = current_customer.addresses.all
      render :index
    end
  end

def destroy
    @address = Address.find(params[:id])
    if @address.customer != current_customer
      redirect_to addresses_path
    else
      @address.destroy
      redirect_to addresses_path
    end
  end



private

  def address_params
    params.require(:address).permit( :name, :postal_code, :address)
  end

end
