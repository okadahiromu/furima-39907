class ItemsController < ApplicationController
  def index
  end

  def item_params
    params.require(:item).permit(:name, :price, :description, :category_id, :shopping_cost_id, :item_status_id, :prefecture_id :shopping_date_id).merge(user_id: current_user.id)
  end
end
