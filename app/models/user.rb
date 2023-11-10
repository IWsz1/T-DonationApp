class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
# with_optionsを使用すると同じバリデーwy音を複数の値へ一気にかけることができる
with_options presence: true do
  # バリデーションの設定とmessageでエラーメッセージの指定
   validates :name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "ひらがな/カタカナ/漢字が使用できます。" }
   validates :name_reading, format: { with: /\A[ァ-ヶー]+\z/, message: "カタカナが使用できます。" }
   validates :nickname, format: { with: /\A[a-z0-9]+\z/i, message: "半角英数字が使用できます。" }
end

   has_many :donation
end
