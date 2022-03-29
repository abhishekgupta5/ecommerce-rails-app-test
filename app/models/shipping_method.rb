class ShippingMethod < ApplicationRecord
  validates :name, presence: true
  validates :delivery_time_in_days, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}
  validates :country, presence: true, uniqueness: true, inclusion: {in: ISO3166::Country.pluck(:alpha2).flatten}

  class << self
    # Generic method to add a shipping_method. Expects valid name, delivery_time_in_days
    # and country
    # Raises error if unable to add a record
    def add(attributes)
      ShippingMethod.create!(
        name: attributes[:name],
        country: attributes[:country],
        delivery_time_in_days: attributes[:delivery_time_in_days]
      )
    end

    # @param name [String] Shipping method name
    # @param countries_to_delivery_time_map [Hash] map of countries to delivery_time
    # Eg - { "IN": 2, "US": 3 }
    # Raises error if unable to add a record. If a record is invalid,
    # later records are ignored
    # Used to add a specific shipping method to multiple countries
    # with different delivery times
    def add_for_countries(name, countries_to_delivery_time_map)
      countries_to_delivery_time_map.each do |country, delivery_time|
        ShippingMethod.create!(
          name: name,
          country: country,
          delivery_time_in_days: delivery_time
        )
      end
    end

    # @param country [String] alpha2 country code
    # @return [ShippingMethod] deleted object
    # Raises error if not found
    # Delete a shipping_method for a country
    def delete_for_country(country)
      ShippingMethod.find_by_country!(country).destroy!
    end
  end
end