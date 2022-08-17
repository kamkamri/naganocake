class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy

  enum payment_method: {credit_card:0, transfer:1 }
  enum order_status: {waiting:0, comfirmed:1, doing:2, shipping_preparation:3, shipped:4 }

   # 住所結合
  def address_display
    '〒 ' + postal_code + '　' + address

  end
end
