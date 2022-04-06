class LineItemsController < ApplicationController
  def create
    @cart = @current_cart
    product = Product.find(params[:id])
    if @cart.add_product(product)
      redirect_to products_path
    end
  end

  def add_quantity
    item = LineItem.find(params[:id])
    if item.add_quantity
      redirect_to products_path
    end
  end
  
  def reduce_quantity
    item = LineItem.find(params[:id])
    if item.reduce_quantity
      redirect_to products_path
    end
  end

  def destroy
    item = LineItem.find(params[:id])
    item.destroy
    redirect_to products_path
  end
end
