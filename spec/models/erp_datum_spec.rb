require "rails_helper"

RSpec.describe ErpDatum, type: :model do
  it "validates the presence of entity_id" do
    expect(build_stubbed(:erp_datum, entity_id: nil)).not_to be_valid
  end

  it "validates the presence of order_id" do
    expect(build_stubbed(:erp_datum, order_id: nil)).not_to be_valid
  end
end
