class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @order_buyer = OrderBuyer.new
    @orders = Order.where(user_id: current_user.id)
    render :index
  end

  def new
    @order_buyer = OrderBuyer.new
  end

  def create
    @order_buyer = OrderBuyer.new(order_params)
    @item = Item.find(params[:item_id])
    if @order_buyer.valid?
      @order_buyer.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end
  
  private

  def order_params
    params.require(:order_buyer).permit(:post_code, :city, :block, :building, :phone_number, :prefecture_id, :item_id).merge(user_id: current_user.id)
  end
  

end
