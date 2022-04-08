class Register < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def write(product, cart, message)
    register = Register.new(product_id: product.id, cart_id: cart.id, message: message)
    register.save
  end
end

# Adapter => write_in_txt, write_in_json, write_in_db => write
