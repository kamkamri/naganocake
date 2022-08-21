class Public::ItemsController < ApplicationController

  # 商品一覧【全部、ジャンルごと】　ページネーション対応
  def index
    @genres = Genre.all

    # 検索でサーチ機能
    if params[:keyword]
      @items =  Item.where(is_active: "true").where(["name like ?", "%#{params[:keyword]}%"]).order('id DESC').page(params[:page]).per(8)
      @keyword = params[:keyword]
    # paramsにgenre_idが入っていたら
    elsif params[:genre_id]
      # itemから一致するgenre_idの商品を取得
      @items =  Item.where(is_active: "true", genre_id: params[:genre_id]).order('id DESC').page(params[:page]).per(8)
    else
    # 違う場合は、全てのアイテムを取得
      @items = Item.where(is_active: "true").order('id DESC').page(params[:page]).per(8)
    end

  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end
