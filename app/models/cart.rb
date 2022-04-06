class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items
  
  def add_product(product)
    chosen_product = product
    
    # raise self.inspect
    if self.products.include?(chosen_product)
      item = self.line_items.find_by(:product_id => chosen_product.id)
      item.quantity += 1
    else
      item = LineItem.new
      item.cart_id = self.id
      item.product_id = chosen_product.id
    end
    item.save
  end

  def remove_product(product)
    item = self.line_items.find_by(:product_id => product.id)
    if item
      self.line_items.delete(item)
    end
  end

  def sub_total
    
  end
end
