require 'spec_helper'

describe PrepaidfactoryApi::Client do
  describe 'cancel_order' do
    order_cancelable = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT, TERMINAL))
    order_non_cancelable = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT, TERMINAL, 1, '', false))

    it 'can not cancel an order if the order_id is wrong' do
      expect {
        CLIENT.cancel_order(PrepaidfactoryApi::Requests::CancelOrder.new(0))
      }.to raise_error(PrepaidfactoryApi::OperationCancelOrderNotFound)
    end

    it "can cancel an order [#{order_cancelable.order_id}]" do
      response = CLIENT.cancel_order(PrepaidfactoryApi::Requests::CancelOrder.new(order_cancelable.order_id))
      expect(response.status).to eql('OrderCanceled')
    end

    it "can handle order already canceled [#{order_cancelable.order_id}]" do
      expect{
        CLIENT.cancel_order(PrepaidfactoryApi::Requests::CancelOrder.new(order_cancelable.order_id))
      }.to raise_error(PrepaidfactoryApi::OperationCancelOrderNotOpen)
    end

    it "can not cancel noncancelable order [#{order_non_cancelable.order_id}]" do
      expect {
        CLIENT.cancel_order(PrepaidfactoryApi::Requests::CancelOrder.new(order_non_cancelable.order_id))
      }.to raise_error(PrepaidfactoryApi::OperationCancelOrderNotCancelable)
    end

    it 'can handle wrong request object' do
      expect {
        CLIENT.cancel_order(PrepaidfactoryApi::Requests::ConfirmOrder.new(0))
      }.to raise_error(PrepaidfactoryApi::OperationMalformedRequest)
    end
  end
end
