FactoryBot.define do
  factory :line_item do
    product_id { 1 }
    cart_id { 1 }
    quantity { 1 }
  end
end