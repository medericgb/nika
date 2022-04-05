require 'rails_helper'

RSpec.describe CreateLineItem, type: :interactor do
  let(:product) { FactoryBot.build(:product, code: "", name: "", price: "") }
  let(:cart) { @current_cart }

  subject(:context) do
    line_item_params = { product_id: "", cart_id: "", quantity: 1 }
    CreateLineItem.call(line_item_params: line_item_params)
  end

  describe '.call' do
    context 'with invalid data' do
      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'has errors' do
        expect(context.errors).to be_present
      end
    end

    context 'with valid data' do
      before do
        allow(client).to receive(:valid?).and_return(true)
        allow(Client).to receive(:create).and_return(client)
      end
      it "succeeds" do
        expect(context).to be_a_success
      end

      it "provides the client" do
        expect(context.client).to eq(client)
      end
    end
  end
end
