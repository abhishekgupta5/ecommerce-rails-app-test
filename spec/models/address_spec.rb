RSpec.describe Address do
  it "has a valid factory" do
    expect(build_stubbed(:address)).to be_valid
  end

  it "validates the presence of first_name" do
    expect(build_stubbed(:address, first_name: nil)).not_to be_valid
  end

  it "validates the presence of last_name" do
    expect(build_stubbed(:address, first_name: nil)).not_to be_valid
  end

  it "validates the presence of line1" do
    expect(build_stubbed(:address, line1: nil)).not_to be_valid
  end

  it "validates the presence of zip" do
    expect(build_stubbed(:address, zip: nil)).not_to be_valid
  end

  it "validates the presence of city" do
    expect(build_stubbed(:address, city: nil)).not_to be_valid
  end

  it "validates the presence of state" do
    expect(build_stubbed(:address, state: nil)).not_to be_valid
  end

  it "validates the presence of country" do
    expect(build_stubbed(:address, country: nil)).not_to be_valid
  end
end
