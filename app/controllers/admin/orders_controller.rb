class Admin::OrdersController < ApplicationController

  # 注文履歴一覧
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  # 注文ステータス、それに連動して変わる
  def update
    @order = Order.find(params[:id])
    @order_items = @order.order_items

    # 注文ステータスが「2入金確認：comfirmet」の場合は、orderitemsの、全ての制作ステータスを確認し、
    # それが「0着手不可:cannot_start」だったら、制作ステータスを「0制作待ち：waiting」に変更
    if @order.update(order_params)
    else
      render :show
    end

    if @order.order_status == "comfirmed"
      @order_items.each do |order_item|
        if order_item.craft_status == "cannot_start"
          order_item.update(craft_status: "waiting")
        end
      end
    end
     redirect_to admin_order_path(@order.id)
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end
