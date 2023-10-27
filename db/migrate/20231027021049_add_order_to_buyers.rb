class AddOrderToBuyers < ActiveRecord::Migration[7.0]
  def change
    add_reference :buyers, :order, null: false, foreign_key: true
  end
end
