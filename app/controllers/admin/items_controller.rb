class Admin::ItemsController < ApplicationController

  # adminにログイン前は使えない
  before_action :authenticate_admin!

  # 商品一覧ページ
  def index
    # True 検索機能あり　False 全部の商品表示
    if params[:keyword]
      @items =  Item.where(["name like ?", "%#{params[:keyword]}%"]).order('id DESC').page(params[:page]).per(10)
      @keyword = params[:keyword]
    else
      @items = Item.page(params[:page]).per(10)
    end
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "You have created item successfully."
      # genre#indexにリダイレクト
      redirect_to admin_item_path(@item.id)
    else
      # gnre#index にrender
      @genres = Genre.all
      render :index
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "You have updated item successfully."
      # item#showにリダイレクト
      redirect_to admin_item_path(@item.id)
    else
      @genres = Genre.all
      render :edit
    end
  end

private
  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active, :item_image)
  end

end