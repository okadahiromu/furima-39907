class OrderBuyer
  include ActiveModel::Model
  attr_accessor :post_code, :city, :block, :building, :phone_number, :prefecture, :order_id, :user_id, :item_id, :prefecture_id
  
  with_options presence: true do
    validates :user_id
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: "は「3桁ハイフン4桁」の形式で入力してください" }
    validates :city
    validates :block
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "は10桁以上11桁以内の半角数字で入力してください" }
    validates :prefecture_id
    validates :item_id
  end
  
  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Buyer.create(post_code: post_code, city: city, block: block, building: building, phone_number: phone_number, prefecture_id: prefecture_id, user_id: user_id, item_id: item_id)
  end
end