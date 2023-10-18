class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
  end

  def new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      
      redirect_to @item
    else
      
      render :new
    end
  end

  def item_params
    params.require(:item).permit(:name, :price, :description, :category_id, :shopping_cost_id, :item_status_id, :prefecture_id, :shopping_date_id).merge(user_id: current_user.id)
  end
end
