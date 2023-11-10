require 'rails_helper'

RSpec.describe DonationAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    # フォームオブジェクトはアソシエーションでuserと紐づいていないためuser_idを設定
    @donation_address = FactoryBot.build(:donation_address,user_id:@user.id)
  end

  describe '寄附情報の保存' do
    context '内容に問題ない場合' do
      it "すべての値が正しく入力できていれば保存できる" do
        expect(@donation_address).to be_valid
      end
      it "cityは空でも保存できる" do
        @donation_address.city = ""
        expect(@donation_address).to be_valid
      end
      it "house_numberは空でも保存できる" do
        @donation_address.house_number = ""
        expect(@donation_address).to be_valid
      end
      it "building_nameは空でも保存できる" do
        @donation_address.building_name = ""
        expect(@donation_address).to be_valid
      end
    end
    context '内容に問題がある場合' do
      it "postal_codeが空だと保存できない" do
        @donation_address.postal_code = ""
        @donation_address.valid?
        # binding.pry
        # include 期待結果が含まれているか検証
        expect(@donation_address.errors.full_messages).to include "Postal code can't be blank"
      end
      it "postal_codeが正しい形式でないと保存できない" do
        @donation_address.postal_code = "1234567"
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include "Postal code is invalid"
      end
      it "prefectureを選択していないと保存できない" do
        @donation_address.prefecture = "1"
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include "Prefecture must be other than 1"
      end
      it 'priceが空だと保存できない' do
        @donation_address.price = ""
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include "Price can't be blank"
      end
      
      it 'priceが全角数字だと保存できない' do
        @donation_address.price = ""
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include "Price is not a number"
      end
      
      it 'priceが1円未満では保存できない' do
        @donation_address.price = "0"
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include "Price must be greater than or equal to 1"
      end
      it 'priceが10000000円を超えると保存できない' do
        @donation_address.price = "10000000"
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include "Price must be less than or equal to 1000000"
      end
      it 'userが紐づいていないと保存できない' do
        @donation_address.user_id = ""
        @donation_address.valid?
        # binding.pry
        expect(@donation_address.errors.full_messages).to include "User can't be blank"
      end
    end
  end
end
