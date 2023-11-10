require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '内容に問題ない場合' do
      it "すべての値が正しく入力できていれば保存できる" do
        expect(@user).to be_valid
      end
    end
    context '内容に問題がある場合' do
      it "nameが空だと保存できない" do
        @user.name = ""
        @user.valid?
        # binding.pry
        # include 期待結果が含まれているか検証
        expect(@user.errors.full_messages).to include "Name can't be blank"
      end
      it "name全角の日本語でないと保存できない" do
        @user.name = "asakasora"
        @user.valid?
        # binding.pry
        # include 期待結果が含まれているか検証
        expect(@user.errors.full_messages).to include "Name ひらがな/カタカナ/漢字が使用できます。"
      end
      it "name_readingが空だと保存できない" do
        @user.name_reading = ""
        @user.valid?
        # include 期待結果が含まれているか検証
        expect(@user.errors.full_messages).to include "Name reading can't be blank"
      end
      it 'name_readingが全角カタカナでないと保存できない' do
        @user.name_reading = "あさかそら"
        @user.valid?
        # include 期待結果が含まれているか検証
        # binding.pry
        expect(@user.errors.full_messages).to include "Name reading カタカナが使用できます。"
      end

      it 'nicknameが空だと保存できない' do
        @user.nickname = ""
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end

      it 'nicknameが半角でないと保存できない' do
        @user.nickname = "そら"
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include "Nickname 半角英数字が使用できます。"
      end
    end
  end
end
