class Purchasehistory < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_one :deliveryaddress
end
