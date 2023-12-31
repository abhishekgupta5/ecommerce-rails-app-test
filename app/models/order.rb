class Order < ApplicationRecord
  belongs_to :shipping_address, class_name: "Address"
  belongs_to :credit_card

  has_many :line_items, inverse_of: :order

  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :credit_card

  validates :email, presence: true, format: URI::MailTo::EMAIL_REGEXP

  def total
    line_items.sum(&:total)
  end
end
