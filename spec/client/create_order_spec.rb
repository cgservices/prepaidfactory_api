require 'spec_helper'

describe PrepaidfactoryApi::Client do

  describe 'createOrder' do

    it 'can not create order if the limit (e.g. Paysafe) has been reached per terminal' do
      terminal = "TEST-TERMINAL-#{rand(1..100)}"
      expect {
        CLIENT.createOrder(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['ppf']['retailer_id'], 'C9910', terminal, 1))
      }.to raise_error(PrepaidfactoryApi::TerminalLimitExceeded)
    end

    it 'can handle out-of-stock products' do
      expect {
        CLIENT.createOrder(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['ppf']['retailer_id'], 'SSC50', TERMINAL))
      }.to raise_error(PrepaidfactoryApi::OutOfStock)
    end

    it 'can handle wrong retailer' do
      expect {
        CLIENT.createOrder(PrepaidfactoryApi::Requests::CreateOrder.new('WRONG-RETAILER', PRODUCT, TERMINAL))
      }.to raise_error(PrepaidfactoryApi::RetailerNotFound)
    end

  end
  
end
