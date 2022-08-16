class Public::OrdersController < ApplicationController

  #支払方法、配送先入力画面
  def new
    @order = Order.new
  end


  #注文確認画面
  def confirm
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800
    @total = params[:order][:total].to_i
    @order.total_payment = @order.postage + @total

    # order-分岐
    case params[:order][:select_address]

      # 本人住所
      when "0" then
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.name = current_customer.name_display

      # 登録済配送先
      when "1" then
        @address = Address.find(params[:order][:address_id])
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name

        # 2新規届先は、paramsから受け取った情報のままなので、何もしなくてよい
    end
  end


  # 注文確定処理
  def create
    # @orderインスタンスに確認画面から送られてきたデータを格納
    @order = current_customer.orders.new(order_params)

    # カート内アイテムを、オーダーアイテムに保存するため、全て取得しておく
    # カートアイテムは、viewにデータは渡さないので、＠不要
    cart_items = current_customer.cart_items.all

    # @orderをモデルに保存
    if @order.save
      # cart_item のデータを、一つずつorder_iteモデルに保存
      cart_items.each do |cart_item|
        order_item = OrderItem.new
        order_item.item_id = cart_item.item_id
        order_item.order_id = @order.id
        order_item.price_intax = cart_item.item.with_tax_price
        order_item.amount = cart_item.amount
        # order_itemを保存
        order_item.save
      end

      # カート内商品を全て削除
      cart_items.destroy_all
      redirect_to complete_orders_path
    else
      @order = Order.new(order_params)
      render :new
    end
  end


  def complete
  end


  def index
  end

  def show
  end


  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :postage, :total_payment)
  end
end
