class Admin::HomesController < ApplicationController

  # 全員の注文履歴・個人ごとの注文履歴
  # 個人ごとの場合は、hidden_fieldで、customer_idを、送っている
  # idが、送られてきたら個人ごと、送られてない場合は、全部の注文履歴を表示する

  def top
    # idがブランクか？ブランクなら税院表示
    if params[:id].blank?
      @orders = Order.all
    else
      @orders = Customer.find(params[:id]).orders
    end
  end
end
