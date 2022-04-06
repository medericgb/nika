require 'rails_helper'

RSpec.describe LineItem, type: :model do
  let(:cart) { FactoryBot.create(:cart) }
  let(:product) { FactoryBot.create(:product) }
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
end
