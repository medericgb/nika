class ProductsController < ApplicationController
  def index
    @products = Product.all
    @cart = @current_cart
    @orders = Order.all.reverse
  end
end
