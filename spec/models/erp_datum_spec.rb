require "rails_helper"

RSpec.describe ErpDatum, type: :model do
  it "validates the presence of entity_id" do
    expect(build_stubbed(:erp_datum, entity_id: nil)).not_to be_valid
  end

  it "validates the presence of order_id" do
    expect(build_stubbed(:erp_datum, order_id: nil)).not_to be_valid
  end

  describe "#update_erp_data" do
    it "save erp data on success" do
      order = build_stubbed(:order)

      # Stub client response. We want this spec to be independent of what
      # client does. With this, any changes in client won't need this spec to
      # change. Only client_response method can change if the response changes.
      stub_erp_client_response(order)

      # Ensure that the erp row is not already present
      expect(ErpDatum.where(order: order)).not_to exist
      # No need to test the private methods fetch and save_in_db individually.
      # Testing update_erp_data is necessary and sufficient.
      expect { ErpDatum.update_erp_data(order) }.to change { ErpDatum.count }.by(1)
      # The ERP row should be saved with proper order_id and entity_id
      expect(ErpDatum.where(order: order, entity_id: client_response["id"])).to exist
    end

    def client_response
      {"id" => "or_aeda3f023dcdce28"}
    end

    def stub_erp_client_response(order)
      client = double("ErpClient")
      allow(ErpClient).to receive(:new).with(order) { client }
      allow(client).to receive(:erp_for_order) { client_response }
    end
  end
end
