class Admin::HomesController < ApplicationController

  # adminにログイン前は使えない
  before_action :authenticate_admin!


  # 全員の注文履歴・個人ごとの注文履歴
  # 個人ごとの場合は、hidden_fieldで、customer_idを、送っている
  # idが、送られてきたら個人ごと、送られてない場合は、全部の注文履歴を表示する
  # ページネーション対応
  def top
    # idがブランクか？ブランクなら全員表示、ブランク出ないなら、:idのユーザーの注文履歴を表示
    if params[:id].blank?
      @orders = Order.order('id DESC').page(params[:page]).per(10)
    else
      @orders = Customer.find(params[:id]).orders.order('id DESC').page(params[:page]).per(10)
    end
  end
end
