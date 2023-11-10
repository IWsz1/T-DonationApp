class Donation < ApplicationRecord
  belongs_to :user
  has_one :addresses
  # only_integerで整数のみに
  # 後半で1以上1000000以下の数字にバリデーション
  # validates :price,presence:true, numericality: {only_integer:true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000000 }
end
