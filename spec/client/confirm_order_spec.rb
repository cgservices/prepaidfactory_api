require 'spec_helper'

describe PrepaidfactoryApi::Client do
  describe 'confirm_order' do

    xit 'can not confirm an order if the order_id is wrong' do
      expect {
        CLIENT.confirm_order(PrepaidfactoryApi::Requests::ConfirmOrder.new(0))
      }.to raise_error(PrepaidfactoryApi::OperationOrderNotFound)
    end

    xit "can confirm an order" do
      order = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT, TERMINAL))
      response = CLIENT.confirm_order(PrepaidfactoryApi::Requests::ConfirmOrder.new(order.order_id))
      expect(response.status).to eql('OrderConfirmed')
    end

    xit 'can handle an already confirmed order' do
      order = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT, TERMINAL))
      expect {
        CLIENT.confirm_order(PrepaidfactoryApi::Requests::ConfirmOrder.new(order.order_id))
      }.to raise_error(PrepaidfactoryApi::OperationConfirmNotAllowed)
    end

    xit 'can handle an wrong request object' do
      expect {
        CLIENT.confirm_order(PrepaidfactoryApi::Requests::GetProductInformation.new(0))
      }.to raise_error(PrepaidfactoryApi::OperationMalformedRequest)
    end
  end
end
