require 'spec_helper'

describe 'eVoucher tests required by Prepaid Factory' do
  it '(1) reserve' do
    expect {
      response = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT, TERMINAL))
    }.to_not raise_error
  end

  it '(2) reserve + cancel' do
    expect {
      order = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT, TERMINAL))
      CLIENT.cancel_order(PrepaidfactoryApi::Requests::CancelOrder.new(order.order_id))
    }.to_not raise_error
  end

  it '(3) reserve + confirm' do
    expect {
      order = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT, TERMINAL))
      CLIENT.confirm_order(PrepaidfactoryApi::Requests::ConfirmOrder.new(order.order_id))
    }.to_not raise_error
  end

  it '(4) reserve + confirm + cancel' do
    expect {
      order = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT, TERMINAL))
      CLIENT.confirm_order(PrepaidfactoryApi::Requests::ConfirmOrder.new(order.order_id))
      CLIENT.cancel_order(PrepaidfactoryApi::Requests::CancelOrder.new(order.order_id))
    }.to raise_error(PrepaidfactoryApi::CancelOrderNotOpen)
  end

  it '(5) reserve + cancel (unknown retailer)' do
    expect {
      order = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new('TEST1234567890', PRODUCT, TERMINAL))
      CLIENT.cancel_order(PrepaidfactoryApi::Requests::CancelOrder.new(order.order_id))
    }.to raise_error(PrepaidfactoryApi::RetailerNotFound)
  end

  it '(6) reserve + cancel (unknown product)' do
    expect {
      order = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], 'CSABCDE', TERMINAL))
      CLIENT.cancel_order(PrepaidfactoryApi::Requests::CancelOrder.new(order.order_id))
    }.to raise_error(PrepaidfactoryApi::ProductNotFound)
  end

  it '(7) reserve + cancel (out-of-stock product)' do
    expect {
      order = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], PRODUCT_OUT_OF_STOCK, TERMINAL))
      CLIENT.cancel_order(PrepaidfactoryApi::Requests::CancelOrder.new(order.order_id))
    }.to raise_error(PrepaidfactoryApi::OutOfStock)
  end
end
