RSpec.describe ErpClient do
  describe "#erp_for_order" do
    let(:order) { build_stubbed(:order) }
    let(:address) { order.shipping_address }
    let(:line_item) { build_stubbed(:line_item, order: order) }

    after(:each) do
      # Expect that the HTTP request was made with correct arguments at all times
      expect(ErpClient).to have_received(:post).with(ErpClient::ERP_ENDPOINT, body: request_body.to_json, headers: auth_headers)
    end

    it "success" do
      # Stub the API response for a successful scenario
      stub_response = instance_double("HTTParty::Response", code: 201, parsed_response: success_response)
      allow(ErpClient).to receive(:post) { stub_response }

      response = ErpClient.new(order).erp_for_order

      expect(response).to eq(success_response)
    end

    it "failure - ClientError" do
      # Stub the API response for a failure scenario with client error
      stub_response = instance_double("HTTParty::Response", code: 422)
      allow(ErpClient).to receive(:post) { stub_response }

      expect { ErpClient.new(order).erp_for_order }.to raise_error(Errors::ErpClientError)
    end

    it "failure - ServerError" do
      # Stub the API response for a failure scenario with server error
      stub_response = instance_double("HTTParty::Response", code: 500)
      allow(ErpClient).to receive(:post) { stub_response }

      expect { ErpClient.new(order).erp_for_order }.to raise_error(Errors::ErpServerError)
    end

    ####### Helper methods
    def success_response
      {"id" => "stubbed_response"}
    end

    def request_body
      line_items_data = LineItem.includes(:product).where(order: order).map do |item|
        {product_description: item.product.name,
         quantity: item.quantity,
         total: item.total.to_f}
      end
      {
        order_id: order.id,
        shipping_address: {
          full_name: "#{address.first_name} #{address.last_name}",
          line1: address.line1,
          line2: nil,
          zip: address.zip,
          city: address.city,
          state: address.state,
          country: address.country
        },
        line_items: line_items_data,
        total: order.total.to_f
      }
    end

    def auth_headers
      {"Content-Type" => "application/json",
       "Accept" => "application/json"}
    end
  end
end
