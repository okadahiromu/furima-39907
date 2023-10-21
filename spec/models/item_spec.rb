require 'rails_helper'
require 'factory_bot'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品登録' do
    context '商品出品登録できる場合' do
      it '商品出品登録できる' do
        expect(@item).to be_valid
      end
      it '価格は、¥300から保存可能であること。' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it '価格は、¥999,999まで保存可能であること。' do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end 
    end
    context '商品出品登登録できない場合' do
      it "商品名が必須であること" do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "商品の説明が必須であること" do
        @item.description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it "カテゴリーの情報が必須であること" do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it "商品の状態の情報が必須であること" do 
        @item.item_status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Item status can't be blank")
      end
      it "配送料の負担の情報が必須であること" do
        @item.shopping_cost_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shopping cost can't be blank")
      end
      it "発送元の地域の情報が必須であること" do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "発送までの日数の情報が必須であること" do
        @item.shopping_date_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shopping date can't be blank")
      end
      it "価格の情報が必須であること" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "価格は半角数値のみ保存可能であること" do
        @item.price = "１２３４"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")  
      end
      it '価格は、¥300から保存可能であること。' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")  
      end
      it '価格は、¥999,999まで保存可能であること。' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")  
      end
      it "カテゴリーが 1 の場合は出品できないこと" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it "商品の状態が 1 の場合は出品できないこと" do
        @item.item_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item status can't be blank")
      end

      it "配送料の負担が 1 の場合は出品できないこと" do
        @item.shopping_cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shopping cost can't be blank")
      end

      it "発送元の地域が 1 の場合は出品できないこと" do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it "発送までの日数が 1 の場合は出品できないこと" do
        @item.shopping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shopping date can't be blank")
      end
      it "userが紐付いていなければ出品できないこと" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end

