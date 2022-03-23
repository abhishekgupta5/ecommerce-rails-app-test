class OrdersController < ApplicationController
  def new
    @order = build_order
  end

  def create
    @order = build_order(order_params)

    if @order.save
      cart.clear
      render :summary
    else
      render :new
    end
  end

  private

  def build_order(params = {})
    Order.new(params).tap do |order|
      order.build_shipping_address unless order.shipping_address
      order.build_credit_card unless order.credit_card

      cart.each_pair do |product_id, quantity|
        order.line_items.build(product: Product.find(product_id), quantity: quantity)
      end
    end
  end

  def order_params
    params.require(:order).permit(
      :email,
      shipping_address_attributes: %i[first_name last_name line1 line2 zip city state country],
      credit_card_attributes: %i[number name exp_month exp_year cvc]
    )
  end
end
