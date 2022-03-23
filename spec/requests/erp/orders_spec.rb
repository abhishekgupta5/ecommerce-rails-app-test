RSpec.describe "/erp/orders" do
  describe "POST /" do
    it "responds with 201 Created" do
      payload = build_payload

      post erp_orders_path, params: payload.to_json, headers: {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }

      expect(response.status).to eq(201)
    end

    it "responds with the entity ID" do
      payload = build_payload

      post erp_orders_path, params: payload.to_json, headers: {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }

      expect(JSON.parse(response.body)).to match("id" => an_instance_of(String))
    end

    it "validates the request payload" do
      payload = {invalid: "data"}

      post erp_orders_path, params: payload.to_json, headers: {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }

      expect(response.status).to eq(422)
    end
  end

  private

  def build_payload
    {
      order_id: 1,
      shipping_address: {
        full_name: "John Doe",
        line1: "8400 NW 36th",
        line2: nil,
        zip: "33166",
        city: "Doral",
        state: "FL",
        country: "US"
      },
      line_items: [{
        product_description: "Earthen Bottle",
        quantity: 2,
        total: 15.0
      }],
      total: 30.0
    }
  end
end
