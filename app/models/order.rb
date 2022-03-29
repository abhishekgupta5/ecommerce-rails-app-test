class Order < ApplicationRecord
  belongs_to :shipping_address, class_name: "Address"
  belongs_to :credit_card

  # We assume that there is 1-1 relation of an erp_data row and order
  has_one :erp_data_row, class_name: "ErpDatum"
  has_many :line_items, inverse_of: :order

  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :credit_card

  validates :email, presence: true, format: URI::MailTo::EMAIL_REGEXP

  # Happens async since this depends upon another API call.
  # We don't want our app server to wait for an external call.
  after_create :associate_erp_and_order

  def total
    line_items.sum(&:total)
  end

  def associate_erp_and_order
    ErpUpdaterJob.perform_later(self)
  end

  # @return [Hash] containing shipping_method_name and
  # delivery_time(in days)
  def shipping_info_for_order
    ShippingMethod.delivery_info_for_country(shipping_address.country)
  end
end
