require 'rails_helper'
require 'factory_bot'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
  context '正しい情報でユーザーを登録できる' do
      it '新規登録できる' do
        expect(@user).to be_valid
      end 
    end
  context 'ユーザー新規登録できない場合' do
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'passwordが空だと登録できない' do
      @user.password = ''
      @user.password_confirmation = '00000000'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end 
    it 'passwordが確認用と一致しないと登録できない' do
      @user.password = 'password123'
      @user.password_confirmation = 'password456'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'passwordが6文字未満では登録できない' do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'emailに@が含まれていない場合は登録できない' do
      @user.email = 'invalid-email'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it '名字が空では登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it '名前が空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it '名字が全角文字でない場合は登録できない' do
      @user.last_name = 'Tanaka'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name は全角文字で入力してください")
    end
    it '名前が全角文字でない場合は登録できない' do
      @user.first_name = 'Taro'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name は全角文字で入力してください")
    end
    it '名字カナが全角カタカナであること' do
      @user.last_name_kana = 'ﾀﾅｶ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana は全角カタカナで入力してください")
    end
    it '名前カナが空では登録できないこと' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it '名字カナが空では登録できないこと' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end
    it '名前カナが全角カタカナであること' do
      @user.first_name_kana = 'ﾀﾛｳ'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana は全角カタカナで入力してください")
    end
    it '生年月日が必須であること' do
      @user.birth_date = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
    it '英字のみのパスワードでは登録できない' do
      @user.password = 'password'
      @user.password_confirmation = 'password'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password must include at least one letter and one digit")
    end
    it '数字のみのパスワードでは登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password must include at least one letter and one digit")
    end
    it '全角文字を含むパスワードでは登録できない' do
      @user.password = 'パスワード123'
      @user.password_confirmation = 'パスワード123'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password must include at least one letter and one digit")
    end
    it 'メールアドレスが一意であること' do
      user1 = FactoryBot.create(:user, email: 'acd@com')
      user2 = FactoryBot.build(:user, email: 'acd@com')
      user2.valid?
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end
    end
  end 
end
