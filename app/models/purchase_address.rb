class PurchaseAddress
  include ActiveModel::Model

  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :token

  validates :item_id, :user_id, :postal_code, :prefecture_id, :city, :address, :phone_number, :token, presence: true
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :phone_number, length: { minimum: 10, maximum: 11, too_long: 'is too long (maximum is 11 characters)' }, format: { with: /\A\d{10,11}\z/ }
  
  def save
    purchase = Purchasehistory.create!(item_id: item_id, user_id: user_id,)
    Deliveryaddress.create!(purchasehistory_id: purchase.id, postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number)
  end
end
