require 'rails_helper'
require 'factory_bot'

RSpec.describe OrderBuyer, type: :model do
  describe '商品購入登録' do
    before do
      user = FactoryBot.create(:user)
      @order_buyer = FactoryBot.build(:order_buyer, user_id: user.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_buyer).to be_valid
      end
      it '建物名は任意であること' do
        @order_buyer.building = nil
        expect(@order_buyer).to be_valid
      end
      it '電話番号は10桁の半角数値であること' do
        @order_buyer.phone_number = '12345678901' 
        expect(@order_buyer).to be_valid
      end
      it '電話番号は11桁の半角数値であること' do
        @order_buyer.phone_number = '1234567890' 
        expect(@order_buyer).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が必須であること' do
        @order_buyer.post_code = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと' do
        @order_buyer.post_code = '123456' 
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Post code は「3桁ハイフン4桁」の形式で入力してください")
      end
      it '都道府県が必須であること' do
        @order_buyer.prefecture_id = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "都道府県が 1 の場合は出品できないこと" do
        @order_buyer.prefecture_id = 1
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が必須であること' do
        @order_buyer.city = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("City can't be blank")
      end
      it '番地が必須であること' do
        @order_buyer.block = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Block can't be blank")
      end
      it '電話番号が必須であること' do
        @order_buyer.phone_number = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと' do
        @order_buyer.phone_number = '123456789'
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Phone number は10桁以上11桁以内の半角数字で入力してください")
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと' do
        @order_buyer.phone_number = '123456789999' 
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Phone number は10桁以上11桁以内の半角数字で入力してください")
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと' do
        @order_buyer.phone_number = '123-456-7890' 
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Phone number は10桁以上11桁以内の半角数字で入力してください")
      end
      it 'クレジットカード情報は必須であること' do
        @order_buyer.token = nil 
        @order_buyer.valid? 
        expect(@order_buyer.errors.full_messages).to include("Token can't be blank")
      end
      it "userが紐付いていなければ出品できないこと" do
        @order_buyer.user_id = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("User can't be blank")
      end
      it "itemが紐付いていなければ出品できないこと" do
        @order_buyer.item_id = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Item can't be blank")
      end
      
    end
  end
end
