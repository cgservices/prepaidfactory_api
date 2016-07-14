require 'spec_helper'

describe PrepaidfactoryApi::Client do
  describe 'confirm_order' do
    order = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT, TERMINAL))

    it 'can not confirm an order if the order_id is wrong' do
      expect {
        CLIENT.confirm_order(PrepaidfactoryApi::Requests::ConfirmOrder.new(0))
      }.to raise_error(PrepaidfactoryApi::OrderNotFound)
    end

    it "can confirm an order [#{order.order_id}]" do
      response = CLIENT.confirm_order(PrepaidfactoryApi::Requests::ConfirmOrder.new(order.order_id))
      expect(response.status).to eql('OrderConfirmed')
    end

    it 'can handle an already confirmed order' do
      expect {
        CLIENT.confirm_order(PrepaidfactoryApi::Requests::ConfirmOrder.new(order.order_id))
      }.to raise_error(PrepaidfactoryApi::ConfirmNotAllowed)
    end

    it 'can handle an wrong request object' do
      expect {
        CLIENT.confirm_order(PrepaidfactoryApi::Requests::GetProductInformation.new(0))
      }.to raise_error(PrepaidfactoryApi::MalformedRequest)
    end
  end
end
