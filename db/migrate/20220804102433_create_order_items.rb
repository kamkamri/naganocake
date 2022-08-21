class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|

      t.integer :item_id, null: false
      t.integer :order_id, null: false
      t.integer :price_intax, null: false
      t.integer :amount, null: false
      t.integer :craft_status, null: false, default: 0

      t.timestamps
    end
  end
end
