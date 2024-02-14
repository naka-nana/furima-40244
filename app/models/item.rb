class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  belongs_to :category, class_name: 'Category'
  belongs_to :condition, class_name: 'Condition'
  belongs_to :prefecture, class_name: 'Prefecture'
  belongs_to :shipping_fee, class_name: 'ShippingFee'
  belongs_to :shipping_day, class_name: 'ShippingDay'

  validates :name, presence: true
  validates :description, presence: true
  validates :category_id, numericality: { other_than: 1 }
  validates :condition_id, numericality: { other_than: 1 }
  validates :prefecture_id, numericality: { other_than: 1 }
  validates :shipping_fee_id, numericality: { other_than: 1 }
  validates :shipping_day_id, numericality: { other_than: 1 }
  validate :image_presence
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  private

  def image_presence
    errors.add(:image, 'を1枚つけてください') unless image.attached?
  end
end
