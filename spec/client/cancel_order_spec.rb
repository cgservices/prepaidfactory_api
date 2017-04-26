require 'spec_helper'

describe PrepaidfactoryApi::Client do
  describe 'cancel_order' do
    xit 'can not cancel an order if the order_id is wrong' do
      expect {
        CLIENT.cancel_order(PrepaidfactoryApi::Requests::CancelOrder.new(0))
      }.to raise_error(PrepaidfactoryApi::OperationCancelOrderNotFound)
    end

    xit "can cancel an order" do
      order_cancelable = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT, TERMINAL))
      response = CLIENT.cancel_order(PrepaidfactoryApi::Requests::CancelOrder.new(order_cancelable.order_id))
      expect(response.status).to eql('OrderCanceled')
    end

    xit "can handle order already canceled" do
      order_cancelable = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT, TERMINAL))
      CLIENT.cancel_order(PrepaidfactoryApi::Requests::CancelOrder.new(order_cancelable.order_id))
      expect {
        order_id = 9186 # @NOTE Match for fixtures
        order_id ||= order_cancelable.order_id
        CLIENT.cancel_order(PrepaidfactoryApi::Requests::CancelOrder.new(order_id))
      }.to raise_error(PrepaidfactoryApi::OperationCancelOrderNotOpen)
    end

    xit "can not cancel noncancelable order" do
      order_non_cancelable = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT, TERMINAL, 1, '', false))
      expect {
        CLIENT.cancel_order(PrepaidfactoryApi::Requests::CancelOrder.new(order_non_cancelable.order_id))
      }.to raise_error(PrepaidfactoryApi::OperationCancelOrderNotCancelable)
    end

    xit 'can handle wrong request object' do
      expect {
        CLIENT.cancel_order(PrepaidfactoryApi::Requests::ConfirmOrder.new(0))
      }.to raise_error(PrepaidfactoryApi::OperationMalformedRequest)
    end
  end
end
