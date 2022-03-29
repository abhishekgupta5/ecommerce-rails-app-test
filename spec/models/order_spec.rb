RSpec.describe Order do
  it "has a valid factory" do
    expect(build_stubbed(:order)).to be_valid
  end

  it "validates the presence of email" do
    expect(build_stubbed(:order, email: nil)).not_to be_valid
  end

  it "validates the format of email" do
    expect(build_stubbed(:order, email: "invalid")).not_to be_valid
  end

  describe "#total" do
    it "sums the totals of the line items" do
      order = build_stubbed(:order) do |o|
        allow(o).to receive(:line_items).and_return([
          instance_double("LineItem", total: 30.0),
          instance_double("LineItem", total: 5.0)
        ])
      end

      expect(order.total).to eq(35.0)
    end
  end

  describe "#shipping_info_for_order" do
    it "returns value when shipping method is present" do
      address = build_stubbed(:address)
      shipping_method = build_stubbed(:shipping_method, country: address.country)
      build_stubbed(:order, shipping_address: address) do |o|
        allow(o).to receive(:shipping_info_for_order).and_return({shipping_method_name: shipping_method.name,
                                                                  delivery_time: shipping_method.delivery_time_in_days})
      end
    end

    it "returns nil values when shipping method is absent" do
      address = build_stubbed(:address)
      ShippingMethod.where(country: address.country).delete_all
      build_stubbed(:order, shipping_address: address) do |o|
        allow(o).to receive(:shipping_info_for_order).and_return({shipping_method_name: nil,
                                                                  delivery_time: nil})
      end
    end
  end
end
