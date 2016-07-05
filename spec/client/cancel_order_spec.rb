require 'spec_helper'

class FakeRequest < PrepaidfactoryApi::Requests::Base
end

describe PrepaidfactoryApi::Client do

  describe 'cancelOrder' do

    orderCancelable = CLIENT.createOrder(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['ppf']['retailer_id'], PRODUCT, TERMINAL))
    orderNoncancelable = CLIENT.createOrder(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['ppf']['retailer_id'], PRODUCT, TERMINAL, 1, '', false))

    it 'can not cancel an order if the order_id is wrong' do
      expect {
        CLIENT.cancelOrder(PrepaidfactoryApi::Requests::CancelOrder.new(0))
      }.to raise_error(PrepaidfactoryApi::CancelOrderNotFound)
    end

    it "can cancel an order [#{orderCancelable.order_id}]" do
      response = CLIENT.cancelOrder(PrepaidfactoryApi::Requests::CancelOrder.new(orderCancelable.order_id))
      expect(response.status).to eql('OrderCanceled')
    end

    it "can handle order already canceled [#{orderCancelable.order_id}]" do
      expect{
        CLIENT.cancelOrder(PrepaidfactoryApi::Requests::CancelOrder.new(orderCancelable.order_id))
      }.to raise_error(PrepaidfactoryApi::CancelOrderNotOpen)
    end

    it "can not cancel noncancelable order [#{orderNoncancelable.order_id}]" do
      expect {
        CLIENT.cancelOrder(PrepaidfactoryApi::Requests::CancelOrder.new(orderNoncancelable.order_id))
      }.to raise_error(PrepaidfactoryApi::CancelOrderNotCancelable)
    end

  end

end
