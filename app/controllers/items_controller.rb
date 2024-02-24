class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update]
  before_action :set_select_collections, only: [:new, :create, :show, :edit, :update]
  before_action :redirect_for_sold_out_item, only: [:show, :edit, :update, :destroy]
  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def update
    if @item.update(item_params) && current_user.id == @item.user_id
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def check_user
    redirect_to root_path unless current_user.id == @item.user_id
  end

  def redirect_for_sold_out_item
    if @item&.purchasehistory.present?
      redirect_to root_path, alert: '売却済みの商品は編集できません。'
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :prefecture_id, :shipping_fee_id,
                                 :shipping_day_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_select_collections
    @categories = Category.all
    @conditions = Condition.all
    @prefectures = Prefecture.all
    @shipping_fees = ShippingFee.all
    @shipping_days = ShippingDay.all
  end
end
