require 'spec_helper'

class FakeRequest < PrepaidfactoryApi::Requests::Base
end

describe PrepaidfactoryApi::Client do

  describe 'confirmOrder' do

    order = CLIENT.createOrder(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['ppf']['retailer_id'], PRODUCT, TERMINAL))

    it 'can not confirm an order if the order_id is wrong' do
      expect {
        CLIENT.confirmOrder(PrepaidfactoryApi::Requests::ConfirmOrder.new(0))
      }.to raise_error(PrepaidfactoryApi::OrderNotFound)
    end

    it "can confirm an order [#{order.order_id}]" do
      response = CLIENT.confirmOrder(PrepaidfactoryApi::Requests::ConfirmOrder.new(order.order_id))
      expect(response.status).to eql('OrderConfirmed')
    end

    it 'can handle an already confirmed order' do
      expect {
        CLIENT.confirmOrder(PrepaidfactoryApi::Requests::ConfirmOrder.new(order.order_id))
      }.to raise_error(PrepaidfactoryApi::ConfirmNotAllowed)
    end

    it 'can handle an wrong request object' do
      expect {
        CLIENT.confirmOrder(PrepaidfactoryApi::Requests::GetProductInformation.new(0))
      }.to raise_error(PrepaidfactoryApi::WrongRequestObject)
    end

  end

end
