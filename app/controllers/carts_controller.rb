class CartsController < ApplicationController
  def show
    @cart = @current_cart
  end

  def clear_cart
    cart = @current_cart
    cart.line_items.delete_all
    # redirect_to root_path
  end

  # def destroy
  #   @cart = @current_cart
  #   @cart.destroy
  #   session[:cart_id] = nil
  #   redirect_to root_path
  # end
end