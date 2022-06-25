class User < ApplicationRecord

  # device用メソッド。必要に応じて、追加すること
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
         
  # ユーザー登録用のバリデーション。
  # ユーザーネームは一意で15文字以下に
  validates  :name, presence: true, uniqueness: true, length: { maximum: 15 }
  # asteriskのセキュリティの観点から、4文字の内線番号を強要する
  validates :src, presence: true, uniqueness: true,length: { is: 4 }
  # asteriskの保守・運用の観点から、英数字&12文字以下を強要する
  validates  :telephone_pass, presence: true,length: { maximum: 12 }, format: { with: /\A[a-zA-Z1-9]+\z/ }  
end
