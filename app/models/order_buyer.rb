class OrderBuyer
  include ActiveModel::Model
  attr_accessor :post_code, :city, :block, :building, :phone_number, :prefecture_id, :order_id, :user_id, :item_id
  
  with_options presence: true do
    validates :user_id
    validates :post_code, format: { with: /\A\d+\z/, message: "半角数字で入力して下さい" }
    validates :city
    validates :block
    validates :phone_number, format: { with: /\A\d+\z/, message: "半角数字で入力して下さい" }
    validates :prefecture_id
    validates :item_id
  end
  
  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Buyer.create(post_code: post_code, city: city, block: block, building: building, phone_number: phone_number, prefecture_id: prefecture.id, order_id: order.id, user_id: user.id, item_id: item.id)
  end
end