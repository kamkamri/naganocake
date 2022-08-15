class Public::CustomersController < ApplicationController
  def show
    # current_customerで、現在のろぐいんしている人のcustomerモデルの情報と入手できる
    # deviseのモデルのみで使用できる
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      flash[:notice] = "You have updated customer successfully."
      # item#showにリダイレクト
      redirect_to customers_path
    else
      render :edit
    end
  end

  def confirm
    @customer = Customer.find(current_customer.id)
  end

  def withdrawal
    @customer = Customer.find(current_customer.id)
    @customer.update(is_active: true)
    reset_session
    redirect_to items_path
  end


  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number)
  end

end
