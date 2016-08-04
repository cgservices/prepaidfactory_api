require 'spec_helper'

describe PrepaidfactoryApi::Client do
  describe 'create_order' do
    it 'can create a valid order with workable response' do
      expect {
        response = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT, TERMINAL))
        response.each { |var, value|
          # puts "#{var.to_s.ljust(30)}: #{value}"
        }
      }.to_not raise_error
    end

    it 'can not create order if the limit (e.g. Paysafe) has been reached per terminal' do
      expect {
        55.times do
          order = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT_WITH_LIMIT, TERMINAL, 1))
          CLIENT.confirm_order(PrepaidfactoryApi::Requests::ConfirmOrder.new(order.order_id))
        end
      }.to raise_error(PrepaidfactoryApi::OperationTerminalLimitExceeded)
    end

    it 'can handle out-of-stock products' do
      expect {
        CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT_OUT_OF_STOCK, TERMINAL))
      }.to raise_error(PrepaidfactoryApi::OperationOutOfStock)
    end

    it 'can handle wrong retailer' do
      expect {
        CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new('WRONG-RETAILER', PRODUCT, TERMINAL))
      }.to raise_error(PrepaidfactoryApi::OperationRetailerNotFound)
    end

    it 'can handle a product not found response' do
      expect {
        CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT_NOT_FOUND, TERMINAL))
      }.to raise_error(PrepaidfactoryApi::OperationProductNotFound)
    end
  end
end
