class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:edit, :show, :update]

  def index
    @items = Item.order("created_at DESC")
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

  def show
   
  end

  def edit
   
    if current_user == @item.user
     
    else
      redirect_to root_path
    end
  end

  def update
    
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :category_id, :shopping_cost_id, :item_status_id, :prefecture_id, :shopping_date_id, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
