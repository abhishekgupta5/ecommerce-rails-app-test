class CartItemsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])

    cart[@product.id.to_s] = (cart[@product.id.to_s] || 0) + 1

    redirect_to new_order_path
  end
end
