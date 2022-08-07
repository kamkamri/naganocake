class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
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
  end

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active, :item_image)
  end

end