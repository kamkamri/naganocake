class Address < ApplicationRecord
  belongs_to :customer

  # バリデーション設定　未入力のチェック
  validates :name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true

end
