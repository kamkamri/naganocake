class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  enum craft_status: {cannot_start:0, waiting:1, doing:2, done:3 }

  # 小計を求めるメソッド
  def subtotal
    price_intax * amount
  end

end
