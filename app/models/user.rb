class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  

  validates :nickname, presence: true
  validates :nickname, uniqueness: true
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龠々]+\z/, message: "は全角文字で入力してください" }
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力してください" }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龠々]+\z/, message: "は全角文字で入力してください" }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力してください" }
  validates :birth_date, presence: true 
  validates :password, length: { minimum: 6 }  
  validates :email, presence: true, format: { with: /@/ }, uniqueness: true
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)/, message: "must include at least one letter and one digit" }
  validate :password_match

  def password_match
    if password != password_confirmation
      errors.add(:password, "must match confirmation")
    end
  end   
end
