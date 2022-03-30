class Order < ApplicationRecord
  belongs_to :shipping_address, class_name: "Address"
  belongs_to :credit_card

  # We assume that there is 1-1 relation of an erp_data row and order
  has_one :erp_data_row, class_name: "ErpDatum"
  has_many :line_items, inverse_of: :order

  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :credit_card

  validates :email, presence: true, format: URI::MailTo::EMAIL_REGEXP
  # We don't support order creation for countries where we don't
  # have a shipping method.
  validate :deliverable_shipping_country

  # Happens async since this depends upon another API call.
  # We don't want our app server to wait for an external call.
  after_create :associate_erp_and_order

  def total
    line_items.sum(&:total)
  end

  # @return [Hash] containing shipping_method_name and
  # delivery_time(in days)
  def shipping_info_for_order
    ShippingMethod.delivery_info_for_country(shipping_address.country)
  end

  private

  def associate_erp_and_order
    ErpUpdaterJob.perform_later(self)
  end

  def deliverable_shipping_country
    if ShippingMethod.allowed_countries_for_shipping.exclude?(shipping_address.country)
      errors.add(:shipping_address, "We don't deliver to #{shipping_address.country} yet")
    end
  end
end
