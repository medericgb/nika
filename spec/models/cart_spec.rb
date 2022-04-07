require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:product_a) { FactoryBot.create(:product) }
  let(:product_b) { FactoryBot.create(:product, code: "MG1", name: "Mango", price: 3.99) }
  let(:grn) { FactoryBot.create(:product, code: "GR1", name: "Green", price: 3.11) }
  let(:str) { FactoryBot.create(:product, code: "SR1", name: "Strawberries", price: 5.00) }
  let(:cff) { FactoryBot.create(:product, code: "CF1", name: "Coffee", price: 11.23) }
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

  describe ".total_price" do
    it "contain GR1,SR1,GR1,GR1,CF1" do
      cart.add_product(grn)
      cart.add_product(str)
      cart.add_product(grn)
      cart.add_product(grn)
      cart.add_product(cff)
      expect(cart.total_price).to eq(22.45)
    end

    it "contain GR1,GR1" do
      cart.add_product(grn)
      cart.add_product(grn)
      expect(cart.total_price).to eq(3.11)
    end

    it "contain SR1,SR1,GR1,SR1" do
      cart.add_product(str)
      cart.add_product(str)
      cart.add_product(grn)
      cart.add_product(str)
      expect(cart.total_price).to eq(16.61)
    end

    it "contain GR1,CF1,SR1,CF1,CF1" do
      cart.add_product(grn)
      cart.add_product(cff)
      cart.add_product(str)
      cart.add_product(cff)
      cart.add_product(cff)
      expect(cart.total_price).to eq(30.57)
    end
  end
end
