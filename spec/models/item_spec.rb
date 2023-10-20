require 'rails_helper'
require 'factory_bot'

RSpec.describe Item, type: :model do
  before do
    shopping_date = ShoppingDate.find_by(name: '1~2日で発送')
    @item = FactoryBot.build(:item, shopping_date: shopping_date)
  end

  describe '商品出品登録' do
      it "商品名が必須であること" do
        @item.name = nil
        expect(@item).not_to be_valid
      end
      it "商品の説明が必須であること" do
        @item.description = nil
        expect(@item).not_to be_valid
      end
      it "カテゴリーの情報が必須であること" do
        @item.category_id = nil
        expect(@item).not_to be_valid
      end
      it "商品の状態の情報が必須であること" do
        @item.item_status_id = nil
        expect(@item).not_to be_valid
      end
      it "配送料の負担の情報が必須であること" do
        @item.shopping_cost_id = nil
        expect(@item).not_to be_valid
      end
      it "発送元の地域の情報が必須であること" do
        @item.prefecture_id = nil
        expect(@item).not_to be_valid
      end
      it "発送までの日数の情報が必須であること" do
        @item.shopping_date_id = nil
        expect(@item).not_to be_valid
      end
      it "価格の情報が必須であること" do
        @item.price = nil
        expect(@item).not_to be_valid
      end
      it "価格は半角数値のみ保存可能であること" do
        @item.price = "１２３４"  
        expect(@item).not_to be_valid
        expect(@item.errors[:price]).to include("is not a number")
      
        @item.price = "1234"  
        expect(@item).to be_valid
      end
      it '価格は、¥300~¥9,999,999の間のみ保存可能であること。' do
        @item.price = 300
        expect(@item).to be_valid
    
        @item.price = 9_999_999
        expect(@item).to be_valid
    
        @item.price = 299
        expect(@item).to_not be_valid
  
        @item.price = 10_000_000
        expect(@item).to_not be_valid
      end
    end
end

