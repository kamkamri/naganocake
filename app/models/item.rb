class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  belongs_to :genre

  #画像投稿
  has_one_attached :item_image


  # 画像がない場合のno-image設定
  # 画像リサイズ
  def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      item_image.variant(resize_to_limit: [width, height]).processed
  end


  # 消費税を求めるメソッド
  # floorメソッドは、小数点以下の小さい方の整数に丸める
  def with_tax_price
    (price*1.1).floor
  end
end
