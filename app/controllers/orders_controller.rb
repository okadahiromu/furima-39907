class OrdersController < ApplicationController

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
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
      pay_item
      @order_buyer.save
      return redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end
  
  private

  def order_params
    params.require(:order_buyer).permit(:post_code, :city, :block, :building, :phone_number, :prefecture_id).merge(user_id: current_user.id, token: params[:token], item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
        Payjp::Charge.create(
          amount: @item.price, 
          card: order_params[:token],    
          currency: 'jpy'                 
        )
  end
end
