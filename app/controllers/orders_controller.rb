class OrdersController < ApplicationController
  def create
    if !@current_cart.line_items.empty?
      @order = Order.new(cart_id: @current_cart.id, is_validated: true)
      @order.save
      # Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
    end
    redirect_to root_path
  end
end