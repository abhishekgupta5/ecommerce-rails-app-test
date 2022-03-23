RSpec.describe LineItem do
  it "has a valid factory" do
    expect(build_stubbed(:line_item)).to be_valid
  end

  it "validates the presence of quantity" do
    expect(build_stubbed(:line_item, quantity: nil)).not_to be_valid
  end

  it "validates quantity is an integer greater than 0" do
    aggregate_failures do
      expect(build_stubbed(:line_item, quantity: "invalid")).not_to be_valid
      expect(build_stubbed(:line_item, quantity: 0)).not_to be_valid
    end
  end

  describe "#total" do
    it "returns the price multiplied by the quantity" do
      product = build_stubbed(:product, price: 15.0)
      line_item = build_stubbed(:line_item, product: product, quantity: 2)

      expect(line_item.total).to eq(30.0)
    end
  end
end
