class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items
  
  def add_product(product)
    chosen_product = product
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

  def total_price
    sum = 0
    self.line_items.each { |item| sum += item.sub_total }
    return sum
  end
end
