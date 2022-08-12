class Public::CustomersController < ApplicationController
  def show
    # current_customerで、現在のろぐいんしている人のcustomerモデルの情報と入手できる
    # deviseのモデルのみで使用できる
    @customer = current_customer
  end

  def edit
  end

  def confirm
  end
end
