class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validate :image_presence
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  private

  def image_presence
    errors.add(:image, 'を1枚つけてください') unless image.attached?
  end
end
