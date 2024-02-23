class Purchasehistory < ApplicationRecord
  attr_accessor :token

  validates :token, presence: true
  belongs_to :item
  belongs_to :user
  has_one :deliveryaddress
end
