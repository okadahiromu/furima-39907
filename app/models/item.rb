class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :order
  
  belongs_to :category
  belongs_to :user
  belongs_to :item_status
  belongs_to :shopping_cost
  belongs_to :prefecture
  belongs_to :shopping_date
  has_one_attached :image

  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :item_status_id, presence: true
  validates :shopping_cost_id, presence: true
  validates :prefecture_id, presence: true
  validates :shopping_date_id, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_status_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shopping_date_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shopping_cost_id, numericality: { other_than: 1 , message: "can't be blank"}
end
