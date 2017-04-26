require 'spec_helper'

describe 'eVoucher tests required by Prepaid Factory', order: :defined do
  xit '(1) reserve' do
    expect {
      response = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT, TERMINAL))
    }.to_not raise_error
  end

  xit '(2) reserve + cancel' do
    expect {
      order = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT, TERMINAL))
      CLIENT.cancel_order(PrepaidfactoryApi::Requests::CancelOrder.new(order.order_id))
    }.to_not raise_error
  end

  xit '(3) reserve + confirm' do
    expect {
      order = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT, TERMINAL))
      CLIENT.confirm_order(PrepaidfactoryApi::Requests::ConfirmOrder.new(order.order_id))
    }.to_not raise_error
  end

  xit '(4) reserve + confirm + cancel' do
    expect {
      order = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT, TERMINAL))
      CLIENT.confirm_order(PrepaidfactoryApi::Requests::ConfirmOrder.new(order.order_id))
      CLIENT.cancel_order(PrepaidfactoryApi::Requests::CancelOrder.new(order.order_id))
    }.to raise_error(PrepaidfactoryApi::OperationCancelOrderNotOpen)
  end

  xit '(5) reserve + cancel (unknown retailer)' do
    expect {
      order = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new('PPF-RETAILER-TEST-ID', PRODUCT, TERMINAL))
    }.to raise_error(PrepaidfactoryApi::OperationRetailerNotFound)
  end

  xit '(6) reserve + cancel (unknown product)' do
    expect {
      order = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], 'CSABCDE', TERMINAL))
    }.to raise_error(PrepaidfactoryApi::OperationProductNotFound)
  end

  xit '(7) reserve + cancel (out-of-stock product)' do
    expect {
      order = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT_OUT_OF_STOCK, TERMINAL))
    }.to raise_error(PrepaidfactoryApi::OperationOutOfStock)
  end
end
