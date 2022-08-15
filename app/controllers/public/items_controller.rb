class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    # ステータスが販売中の商品を取得
    @items = Item.where(is_active: "true")
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
