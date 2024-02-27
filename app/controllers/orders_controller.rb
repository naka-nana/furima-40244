class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :redirect_user, only: [:index, :create]
  before_action :redirect_seller, only: [:edit, :update, :destroy]
  before_action :redirect_for_sold_out_item, only: [:show, :edit, :update, :destroy]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @purchase_address = PurchaseAddress.new
    @prefectures = Prefecture.all
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_address_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path, notice: '購入が完了しました。'
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      @prefectures = Prefecture.all
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def def redirect_seller
    if current_user.nil? || current_user.id != @item.user_id
      redirect_to root_path, alert: '自身が出品した商品の購入ページにはアクセスできません。'
    end
  end

  def redirect_user
    if current_user.id == @item.user_id || @item.purchase_history,present?
      redirect_to root_path
    end
  end

  def redirect_for_sold_out_item
    if @item&.purchasehistory.present?
      redirect_to root_path, alert: '売却済みの商品は編集できません。'
    end
  end

  def purchase_address_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: purchase_address_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end
end
