class Address < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :line1, presence: true
  validates :zip, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true, inclusion: {in: ISO3166::Country.pluck(:alpha2).flatten}
end
