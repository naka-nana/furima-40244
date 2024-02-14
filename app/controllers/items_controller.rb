class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_select_collections, only: [:new, :create]

  def index
    # @items = Item.order('created_at DESC')
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

  private

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
