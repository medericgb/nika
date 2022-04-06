require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:product_a) { FactoryBot.create(:product) }
  let(:product_b) { FactoryBot.create(:product, code: "MG1", name: "Mango", price: 3.99) }
  let(:cart) { FactoryBot.create(:cart) }
  let(:line_item) { FactoryBot.create(:line_item, product_id: product_a.id, cart_id: cart.id, quantity: 1) }

  describe ".add_product" do
    context "when adding one product of type a" do
      it "cart contain one item" do
        cart.add_product(product_a)
        expect(cart.line_items.size).to eq 1
      end

      context "when adding other product of type a" do
        it "increment quantity of item" do
          cart.add_product(product_a)
          cart.add_product(product_a)
          item = cart.line_items.find { |p| p.product_id == product_a.id }
          expect(item.quantity).to eq 2
        end
      end

      context "when adding product of type b" do
        it "cart contain two items" do
          cart.add_product(product_a)
          prec_cart_size = cart.line_items.size
          cart.add_product(product_b)
          rec_cart_size = cart.line_items.size
          expect(rec_cart_size).to eq(prec_cart_size + 1)
        end
      end
    end
  end

  describe ".remove_product" do
    it "remove item from cart" do
      cart.add_product(product_a)
      cart.remove_product(product_a)
      expect(cart.products).not_to include(product_a)
    end
  end

  describe ".sub_total" do
    
  end
end
