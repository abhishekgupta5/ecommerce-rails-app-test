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
end
