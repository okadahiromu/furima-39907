class OrdersController < ApplicationController
  before_action :check_access, only: [:new, :index]


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

  def check_access
    @item = Item.find(params[:item_id])
  
    if !user_signed_in? || current_user == @item.user || Order.exists?(item_id: @item.id)
      redirect_to user_signed_in? ? root_path : new_user_session_path
    end
  end
end
