class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all
    # @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
    @categories = Category.all
    @item_status = ItemStatus.all
    @shopping_cost = ShoppingCost.all
    @prefectures = Prefecture.all
    @shopping_date = ShoppingDate.all
  end 

  def create
    @item = Item.new(item_params)
    @categories = Category.all
    @item_status = ItemStatus.all
    @shopping_cost = ShoppingCost.all
    @prefectures = Prefecture.all
    @shopping_date = ShoppingDate.all

    if @item.save
      redirect_to root_path
    else
      Rails.logger.error(@item.errors.full_messages)  
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :category_id, :shopping_cost_id, :item_status_id, :prefecture_id, :shopping_date_id, :image).merge(user_id: current_user.id)
  end
end
