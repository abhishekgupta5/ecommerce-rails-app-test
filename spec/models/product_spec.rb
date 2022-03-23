RSpec.describe Product do
  it "has a valid factory" do
    expect(build_stubbed(:product)).to be_valid
  end

  it "validates the presence of name" do
    expect(build_stubbed(:product, name: nil)).not_to be_valid
  end

  it "validates the presence of price" do
    expect(build_stubbed(:product, price: nil)).not_to be_valid
  end

  it "validates price is a number greater than or equal to 0" do
    expect(build_stubbed(:product, price: -0.1)).not_to be_valid
  end

  it "validates the presence of image" do
    expect(build_stubbed(:product, image: nil)).not_to be_valid
  end
end
