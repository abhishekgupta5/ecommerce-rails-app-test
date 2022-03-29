require "rails_helper"

RSpec.describe ShippingMethod, type: :model do
  it "has a valid factory" do
    expect(build_stubbed(:shipping_method)).to be_valid
  end

  it "validates the presence of name" do
    expect(build_stubbed(:shipping_method, name: nil)).not_to be_valid
  end

  it "validates the presence of delivery_time_in_days" do
    expect(build_stubbed(:shipping_method, delivery_time_in_days: nil)).not_to be_valid
  end

  it "validates the presence of country" do
    expect(build_stubbed(:shipping_method, country: nil)).not_to be_valid
  end

  it "validates that any invalid country isn't saved" do
    expect(build_stubbed(:shipping_method, country: "RANDOM")).not_to be_valid
  end

  it "validates the numericality of delivery_time_in_days" do
    expect(build_stubbed(:shipping_method, delivery_time_in_days: 0)).not_to be_valid
  end

  it "validates uniqueness of country" do
    create(:shipping_method, country: :IN)
    expect(build_stubbed(:shipping_method, country: :IN)).to_not be_valid
  end

  describe "#add" do
    it "creates shipping method with valid attributes" do
      expect do
        ShippingMethod.add(shipping_method_valid_attributes)
      end.to change { ShippingMethod.count }.by(1)
    end
  end

  describe "#add_for_countries" do
    it "creates shipping method with valid attributes" do
      expect do
        ShippingMethod.add_for_countries("fedex", countries_to_delivery_time_map)
      end.to change { ShippingMethod.count }.by(3)
      # Check data
      expect(ShippingMethod.where(country: countries_to_delivery_time_map.keys)
                           .pluck(:name, :country, :delivery_time_in_days))
        .to match_array(expected_response_add_for_countries)
    end
  end

  describe "#delete_for_country" do
    it "deletes shipping method for a country" do
      record = create(:shipping_method, country: "IN")
      expect do
        ShippingMethod.delete_for_country("IN")
      end.to change { ShippingMethod.count }.by(-1)
      expect { record.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "#delivery_info_for_country" do
    it "delivery_info_for_country for valid country" do
      shipping_method = build_stubbed(:shipping_method)
      allow(ShippingMethod).to receive(:delivery_info_for_country).with(shipping_method.country)
        .and_return({shipping_method_name: shipping_method&.name,
                                                delivery_time: shipping_method&.delivery_time_in_days})
    end

    it "delivery_info_for_country for invalid country" do
      allow(ShippingMethod).to receive(:delivery_info_for_country).with("RANDOM")
        .and_return({shipping_method_name: nil,
                                                delivery_time: nil})
    end
  end

  private

  def shipping_method_valid_attributes
    {name: "fedex", country: "IN", delivery_time_in_days: 10}
  end

  def countries_to_delivery_time_map
    {IN: 5, US: 2, IT: 3}
  end

  def expected_response_add_for_countries
    [["fedex", "IN", 5], ["fedex", "US", 2], ["fedex", "IT", 3]]
  end
end
