class ShippingMethod < ApplicationRecord
  validates :name, presence: true
  validates :delivery_time_in_days, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}
  validates :country, presence: true, uniqueness: true, inclusion: {in: ISO3166::Country.pluck(:alpha2).flatten}
end
