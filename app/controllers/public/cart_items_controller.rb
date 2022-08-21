class Public::CartItemsController < ApplicationController

   # admin、customerにログイン前は使えない 先に記載した方のログインページに案内。(cusotomer)
  before_action :authenticate_customer!
  # before_action :authenticate_admin!

  def index
    @cart_items = current_customer.cart_items.all
    @total = 0
  end

  # カートに商品を追加
  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    # @cart_items.customer_id = current_customer.id

    # 1追加した商品がカート内に存在するかの判別
    if current_customer.cart_items.find_by(item_id: @cart_item.item_id)

      if params[:cart_item][:amount].present?
        # カートに同じ商品が既にある場合は、選んだ個数を追加する
        @re_cart_item = current_customer.cart_items.find_by(item_id: @cart_item.item_id)
        @re_cart_item.update(amount: @re_cart_item.amount + @cart_item.amount.to_i)
        redirect_to cart_items_path
      else
        redirect_to item_path(@cart_item.item_id)
      end
    #カートに同じ商品が存在しない場合は、カートに追加する
    else
      if @cart_item.save
        redirect_to cart_items_path
      else
        redirect_to item_path(@cart_item.item_id)
      end

    end
  end

    # 数量を変更
  def update
    @cart_item = current_customer.cart_items.find(params[:id])
    if @cart_item.update(cart_item_params)
      # indexにリダイレクト
      redirect_to cart_items_path
    else
      @cart_items = current_customer.cart_items.all
      render :index
    end
  end

  # カート商品個別削除
  def destroy
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.delete
    redirect_to cart_items_path
  end


  # カート内商品一括削除
  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end