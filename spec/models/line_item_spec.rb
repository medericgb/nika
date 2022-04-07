require 'rails_helper'

RSpec.describe LineItem, type: :model do
  let(:cart) { FactoryBot.create(:cart) }
  let(:product) { FactoryBot.create(:product) }
  let(:grn) { FactoryBot.create(:product, code: "GR1", name: "Green", price: 3.11) }
  let(:str) { FactoryBot.create(:product, code: "SR1", name: "Strawberries", price: 5.00) }
  let(:cff) { FactoryBot.create(:product, code: "CF1", name: "Coffee", price: 11.23) }
  let(:line_item) { FactoryBot.create(:line_item, product_id: product.id, cart_id: cart.id) }
  
  describe ".add_quantity" do
    it "in contain one item" do
      last_qty = line_item.quantity
      line_item.add_quantity
      expect(line_item.quantity).to eq(last_qty + 1)
    end
  end

  describe ".remove_quantity" do
    context "when quantity is more than 1" do
      it "reduce decrement quantity of item" do
        line_item.add_quantity
        last_qty = line_item.quantity
        line_item.reduce_quantity
        expect(line_item.quantity).to eq(last_qty - 1)
      end
    end

    context "when quantity is 1" do
      it "quantity is equal to 1" do
        line_item.reduce_quantity
        expect(line_item.quantity).to eq 1
      end
    end
  end

  describe ".sub_total" do
    context "when cart contain one GR1" do
      it "line item sub price is equal to one product price" do
        cart.add_product(grn)
        item = cart.line_items.find { |item| item.product_id == grn.id }
        expect(item.sub_total).to eq(grn.price)
      end
    end

    context "when cart contain pair GR1" do
      it "line item sub price is equal to half price of all product" do
        cart.add_product(grn)
        cart.add_product(grn)
        item = cart.line_items.find { |item| item.product_id == grn.id }
        expect(item.sub_total).to eq(grn.price * (item.quantity / 2))
      end
    end

    context "when cart contain impair GR1" do
      it "line item sub price is equal to half price of all product" do
        cart.add_product(grn)
        cart.add_product(grn)
        cart.add_product(grn)
        item = cart.line_items.find { |item| item.product_id == grn.id }
        expect(item.sub_total).to eq(((item.quantity / 2) * grn.price) + 3.11)
      end
    end
    
    context "when cart contain less or more than 3 SR1" do
      it "sub price equal to 5.00 if qty is one" do
        cart.add_product(str)
        item = cart.line_items.find { |item| item.product_id == str.id }
        expect(item.sub_total).to eq(5.00)
      end

      it "sub price equal to 10.0 if qty is two" do
        cart.add_product(str)
        cart.add_product(str)
        item = cart.line_items.find { |item| item.product_id == str.id }
        expect(item.sub_total).to eq(str.price * 2)
      end

      it "sub price equal to if qty is equal or more than 3 minus 0.5 by product" do
        cart.add_product(str)
        cart.add_product(str)
        cart.add_product(str)
        item = cart.line_items.find { |item| item.product_id == str.id }
        expect(item.sub_total).to eq((str.price * item.quantity) - (item.quantity * 0.5))
      end
    end

    context "when cart contain less or more than 3 CF1" do
      it "sub price is 11.23 if qty is 1" do
        cart.add_product(cff)
        item = cart.line_items.find { |item| item.product_id == cff.id }
        expect(item.sub_total).to eq(cff.price)
      end

      it "sub price is 11.23 * 2 if qty is 2" do
        cart.add_product(cff)
        cart.add_product(cff)
        item = cart.line_items.find { |item| item.product_id == cff.id }
        expect(item.sub_total).to eq(cff.price * 2)
      end

      it "sub price is (11.23 * qty) * 2/3 if qty is equal or more than 3" do
        cart.add_product(cff)
        cart.add_product(cff)
        cart.add_product(cff)
        item = cart.line_items.find { |item| item.product_id == cff.id }
        expect(item.sub_total).to eq(((cff.price * item.quantity * 2) / 3))
      end
    end
  end
end
