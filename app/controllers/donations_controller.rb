class DonationsController < ApplicationController
    # index以外のアクションを行おうとした際にログインされてなかったらログインページに遷移する設定
    before_action :authenticate_user!, except: :index
  def index
  end
  def new
    # フォームにフォームオブジェクトを指定する用
    @donation_address = DonationAddress.new
  end
  def create 
    # まずすべてのデータをDonationAddressのフォームオブジェクトに保存
    @donation_address = DonationAddress.new(donation_address_params)
    if @donation_address.valid?
      @donation_address.save
      redirect_to root_path
    else
      render :new,status: :unprocessable_entity
    end

    # @donation = Donation.create(donation_params)
    # Address.create(address_params)
    # redirect_to root_path
  end

  private
  def donation_address_params
    # フォームでフォームオブジェクトのdonation_addressを指定したためrequireにdonation_address指定
    params.require(:donation_address).permit(:price,:user_id,:postal_code,:prefecture,:city,:house_number,:building_name).merge(user_id: current_user.id)
  end

  # def donation_params
  #   # ビューでフォームにmodelを指定していないためrequireが必要ない（requireはフォームにmodelを指定するとparamsの中でmodelハッシュが作成されて入力情報が入っているため記入している）
  #   params.permit(:price).merge(user_id: current_user.id)
  # end
  # def address_params
  #   params.permit(:postal_code,:prefecture,:city,:house_number,:building_name).merge(donation_id: @donation.id)
  # end
end
