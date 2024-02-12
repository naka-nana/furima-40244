class ItemsController < ApplicationController
  def index
    @articles = Article.order("created_at DESC")
  end

  def new
    @item = Item.new
    @categories = Category.all
    @conditions = Condition.all
    @prefectures = Prefecture.all
    @shipping_fees = ShippingFee.all
    @shipping_days = ShippingDay.all
  end

  def create
    Item.create(item_params)
    redirect_to '/'
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :image, :text).merge(user_id: current_user.id)
  end
end
