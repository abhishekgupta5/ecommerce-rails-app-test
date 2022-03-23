class Product < ApplicationRecord
  has_one_attached :image

  validates :name, presence: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0.0}
  validates :image, presence: true
end
