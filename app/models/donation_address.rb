class DonationAddress
  # 下記読み込みでFormオブジェクトが利用できるようになる
  include ActiveModel::Model
  # フォームオブジェクトに下記仮想カラムを追加
  attr_accessor :price,:user_id,:postal_code,:prefecture,:city,:house_number,:building_name

  with_options presence:true do
    # only_integerで整数のみに
    # 後半で1以上1000000以下の数字にバリデーション
    validates :price, numericality: {only_integer:true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000000 }
    validates :postal_code, format:{with:/\A[0-9]{3}-[0-9]{4}\z/}
    validates :prefecture, numericality:{other_than:1}
    # アソシエーションで自動的についていたpresenceをformオブジェクトのバリデーションでは追記
    validates :user_id
  end
  # 各DBに保存
  def save
    @donation = Donation.create(price:price,user_id:user_id)
    # ストロングパラメーターでは無いためmergeは使わない
    Address.create(postal_code:postal_code,prefecture:prefecture,city:city,house_number:house_number,building_name:building_name,donation_id:@donation.id)
  end 
end