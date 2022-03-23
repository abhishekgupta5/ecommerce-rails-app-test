module Erp
  class OrdersController < ErpController
    SCHEMA = <<~JSON
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "type": "object",
        "properties": {
          "order_id": {
            "type": "integer"
          },
          "shipping_address": {
            "type": "object",
            "properties": {
              "full_name": {
                "type": "string"
              },
              "line1": {
                "type": "string"
              },
              "line2": {
                "type": "null"
              },
              "zip": {
                "type": "string"
              },
              "city": {
                "type": "string"
              },
              "state": {
                "type": "string"
              },
              "country": {
                "type": "string"
              }
            },
            "required": [
              "full_name",
              "line1",
              "line2",
              "zip",
              "city",
              "state",
              "country"
            ]
          },
          "line_items": {
            "type": "array",
            "items": [
              {
                "type": "object",
                "properties": {
                  "product_description": {
                    "type": "string"
                  },
                  "quantity": {
                    "type": "integer"
                  },
                  "total": {
                    "type": "number"
                  }
                },
                "required": [
                  "product_description",
                  "quantity",
                  "total"
                ]
              }
            ]
          },
          "total": {
            "type": "number"
          }
        },
        "required": [
          "order_id",
          "shipping_address",
          "line_items",
          "total"
        ]
      }
    JSON

    skip_before_action :verify_authenticity_token

    def create
      JSON::Validator.validate!(SCHEMA, JSON.parse(request.raw_post))

      render status: :created, json: {
        id: "or_#{SecureRandom.hex(8)}"
      }
    rescue JSON::Schema::ValidationError => e
      render status: :unprocessable_entity, json: {
        type: "invalid-schema",
        title: "Your request does not match the expected schema.",
        detail: e.message
      }
    end
  end
end
