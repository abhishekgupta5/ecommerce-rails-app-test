class ErpClient
  include Errors
  include HTTParty
  base_uri "http://localhost:3000"
  ERP_ENDPOINT = "/erp/orders"

  attr_reader :order

  def initialize(order)
    @order = order
    @address = order.shipping_address
  end

  def post(body: {})
    handle_errors(body)
  end

  private

  def handle_errors(body)
    response = self.class.post(ERP_ENDPOINT, body: body.merge!(order_payload).to_json, headers: auth_headers)
    case response.code
    when 201
      response
    when (400..499)
      raise ErpClientError
    when (500..599)
      raise ErpServerError
    end
  end

  def order_payload
    # This will generate only 2 DB queries.
    # 1. To get line_items scoped by orders
    # 2. To get products scoped by line items
    line_items_data = LineItem.includes(:product).where(order: order).map do |item|
      {product_description: item.product.name,
       quantity: item.quantity,
       total: item.total.to_f}
    end
    {
      order_id: order.id,
      shipping_address: {
        full_name: "#{@address.first_name} #{@address.last_name}",
        line1: @address.line1,
        line2: nil, # Not sure why this is expecting null in the JSON schema
        zip: @address.zip,
        city: @address.city,
        state: @address.state,
        country: @address.country
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
