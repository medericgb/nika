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
    sub = 0
    if self.product.code == "GR1"
      if self.quantity > 1
        if self.quantity % 2 == 0
          sub = (self.quantity / 2) * self.product.price
        elsif self.quantity % 2 == 1
          sub = ((self.quantity / 2) * self.product.price) + 3.11
        end
      else
        sub = 3.11
      end
    end
    if self.product.code == "SR1" 
      if self.quantity >= 3
        sub = (self.quantity * self.product.price) - (self.quantity * 0.5)  
      else
        sub = self.quantity * self.product.price 
      end
    end
    if self.product.code == "CF1" 
      if self.quantity >= 3
        sub = (self.quantity * self.product.price * 2) / 3  
      else
        sub = self.quantity * self.product.price 
      end
    end  
    return sub.ceil(2)
  end
end
