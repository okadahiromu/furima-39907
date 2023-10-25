class OrdersController < ApplicationController

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def new
    @order_buyer = OrderBuyer.new
  end

  def create
    @order_buyer = OrderBuyer.new(order_params)
    if @order_buyer.valid?
      @order_buyer.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private

  def order_params
    params.require(:order_buyer).permit(:post_code, :city, :block, :building, :phone_number, :prefecture_id, :order_id, :item_id).merge(user_id: current_user.id)
  end
  end

end
