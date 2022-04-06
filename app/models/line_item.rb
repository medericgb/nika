class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def add_quantity
    self.quantity += 1
    self.save
  end

  def reduce_quantity
    if self.quantity > 1
      self.quantity -= 1
    end
    self.save
  end

  def sub_total
    sub = O
    self.quantity * self.product.price 
    if self.product.code == "GR1"
      if self.quantity % 2 != 
    end
    if self.product.code == "SR1" 
    end
    if self.product.code == "CF1" 
    end  
  end
end
