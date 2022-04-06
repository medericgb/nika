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
end
