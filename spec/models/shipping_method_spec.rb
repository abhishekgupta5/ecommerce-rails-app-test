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
end
