require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    context '正しい情報でユーザーを登録できる' do
      it '新規登録できる' do
        user = User.new(nickname: 'testuser',last_name: '田中', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: 'タロウ', email: 'john@example.com', password: 'password123', password_confirmation: 'password123', birth_date: Date.new(1990, 1, 1))
        expect(user).to be_valid
      end 
    end
    context 'ユーザー新規登録できない場合' do
    it 'nicknameが空では登録できない' do
      user = User.new(nickname: '', email: 'test@example', password: '000000', password_confirmation: '000000')
      user.valid?
      expect(user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      user = User.new(nickname: 'test', email: '', password: '000000', password_confirmation: '000000')
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    it 'passwordが空だと登録できない' do
      user = User.new(nickname: 'abe', email: 'kkk@gmail.com', password: '', password_confirmation: '00000000')
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end 
    it 'passwordが確認用と一致しないと登録できない' do
      user = User.new(nickname: 'john', email: 'john@example.com', password: 'password123', password_confirmation: 'password456')
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'passwordが6文字未満では登録できない' do
      user = User.new(nickname: 'mary', email: 'mary@example.com', password: '12345', password_confirmation: '12345')
      user.valid?
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'emailに@が含まれていない場合は登録できない' do
      user = User.new(nickname: 'test', email: 'invalid-email', password: 'password123', password_confirmation: 'password123')
      user.valid?
      expect(user.errors.full_messages).to include("Email is invalid")
    end
    it 'パスワードが半角英数字混合でない場合は登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'pass123', password_confirmation: 'pass123')
      user.valid?
      expect(user.errors.full_messages).not_to include("Password must include both letters and numbers")
    end
    it '名字が空では登録できない' do
      user = User.new(last_name: '', first_name: 'John', email: 'john@example.com', password: 'password123', password_confirmation: 'password123')
      user.valid?
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end
    it '名前が空では登録できない' do
      user = User.new(last_name: 'Doe', first_name: '', email: 'jane@example.com', password: 'password456', password_confirmation: 'password456')
      user.valid?
      expect(user.errors.full_messages).to include("First name can't be blank")
    end
    it '名字が全角文字でない場合は登録できない' do
      user = User.new(last_name: 'Tanaka', first_name: '太郎', email: 'john@example.com', password: 'password123', password_confirmation: 'password123')
      user.valid?
      expect(user.errors.full_messages).to include("Last name は全角文字で入力してください")
    end
    it '名前が全角文字でない場合は登録できない' do
      user = User.new(last_name: '田中', first_name: 'Taro', email: 'john@example.com', password: 'password123', password_confirmation: 'password123')
      user.valid?
      expect(user.errors.full_messages).to include("First name は全角文字で入力してください")
    end
    it '名字カナが全角カタカナであること' do
      user = User.new(last_name: '田中', first_name: '太郎', last_name_kana: 'ﾀﾅｶ', first_name_kana: 'タロウ', email: 'john@example.com', password: 'password123', password_confirmation: 'password123')
      user.valid?
      expect(user.errors.full_messages).to include("Last name kana は全角カタカナで入力してください")
    end
    it '名前カナが空では登録できないこと' do
      user = User.new(last_name_kana: 'タナカ', first_name_kana: '', last_name: '田中', first_name: '太郎', email: 'john@example.com', password: 'password123', password_confirmation: 'password123')
      user.valid?
      expect(user.errors.full_messages).to include("First name kana can't be blank")
    end
    it '名字カナが空では登録できないこと' do
      user = User.new(last_name_kana: '', first_name_kana: 'タロウ', last_name: 'Tanaka', first_name: '太郎', email: 'john@example.com', password: 'password123', password_confirmation: 'password123')
      user.valid?
      expect(user.errors.full_messages).to include("Last name kana can't be blank")
    end
    it '名前カナが全角カタカナであること' do
      user = User.new(last_name: '田中', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: 'ﾀﾛｳ', email: 'john@example.com', password: 'password123', password_confirmation: 'password123')
      user.valid?
      expect(user.errors.full_messages).to include("First name kana は全角カタカナで入力してください")
    end
    it '生年月日が必須であること' do
      user = User.new(last_name: '田中', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: 'タロウ', email: 'john@example.com', password: 'password123', password_confirmation: 'password123', birth_date: nil)
      user.valid?
      expect(user.errors.full_messages).to include("Birth date can't be blank")
    end
    it 'メールアドレスが一意であること' do
      user = User.new(nickname: 'test', password: 'pass123', password_confirmation: 'pass123', email: 'acd@com', last_name: '田中', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: 'タロウ', birth_date: '1930-01-01') 
      user.save
      another_user = User.new(nickname: 'test', password: 'pass123', password_confirmation: 'pass123', email: 'acd@com', last_name: '田中', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: 'タロウ', birth_date: '1930-01-01')
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it 'nicknameが一意であること' do
      user = User.new(nickname: 'test', password: 'pass123', password_confirmation: 'pass123', email: 'acd@com', last_name: '田中', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: 'タロウ', birth_date: '1930-01-01') 
      user.save
      another_user = User.new(nickname: 'test', password: 'pass123', password_confirmation: 'pass123', email: 'abcd@com', last_name: '田中', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: 'タロウ', birth_date: '1930-01-01')
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Nickname has already been taken")
    end
    end
  end 
end
