class Admin::OrderItemsController < ApplicationController

  #制作ステータス変更
  def update
    # @order_itemsは、@order_item 以外のorder_item を格納
    @order_item = OrderItem.find(params[:id])

    if @order_item.update(order_item_params)
    else
      render 'order/show'
    end

    # 制作ステータス：2製作中doingに変更　かつ　注文ステータス　1入金確認comfirmed →注文ステータスを2：製作中doingに変更
    # 制作ステータス：3製作完了done　かつ　他の商品が全て3制作完了　かつ　注文ステータス　2：製作中doingd →注文ステータスを3：発送準備中shipping_preparationに変更
    if @order_item.craft_status == "doing" && @order_item.order.order_status == "comfirmed"
      @order_item.order.update(order_status: "doing")

    elsif @order_item.craft_status == "done"
      # 製作完了以外が存在するか？　したら、何も更新しない　しなかったら（doneしかない）、注文ステータスを変更
      # OrderItem.where(order_id: @order_item.order_id)→orderidに、紐づくorder_itemを、全て表示
      # where.not(id: @order_item.id)→製作ステータスを変えたIDは、見なくていいので、除外
      # where.not(craft_status: "done").exists? 取得してきたテーブルのうち、craft_statusが、done(製作完了)以外があるか確認
       if OrderItem.where(order_id: @order_item.order_id).where.not(id: @order_item.id).where.not(craft_status: "done").exists?
       else
         @order_item.order.update(order_status: "shipping_preparation")
       end
    else
    end
    redirect_to admin_order_path(@order_item.order.id)
  end

  def order_item_params
    params.require(:order_item).permit(:craft_status)
  end

end
