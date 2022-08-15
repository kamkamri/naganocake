class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    # ステータスが販売中の商品の新着4件を表示
    @items = Item.where(is_active: "true").order('id DESC').limit(4)
  end

  def about
  end
end
