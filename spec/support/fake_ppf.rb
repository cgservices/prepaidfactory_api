def xml_fixture(file_name)
  File.open(File.dirname(__FILE__) + '/fixtures/' + file_name + '.xml', 'rb').read.strip
end

RSpec.configure do |config|
  config.before(:each) do
    ############################################################
    # get_product_information_spec.rb
    ############################################################

    # Valid GetProductInformation
    stub_request(:post, CONFIG['endpoint'])
      .with(body: xml_fixture('request/get_product_information/valid'))
      .to_return(status: 200, body: xml_fixture('response/get_product_information/valid'))

    # Wrong RetailerId GetProductInformation
    stub_request(:post, CONFIG['endpoint'])
      .with(body: xml_fixture('request/get_product_information/wrong_retailer_id'))
      .to_return(status: 200, body: xml_fixture('response/get_product_information/wrong_retailer_id'))


    ############################################################
    # create_order_spec.rb
    ############################################################

    # CreateOrder
    stub_request(:post, CONFIG['endpoint'])
      .with(body: xml_fixture('request/create_order/valid'))
      .to_return(status: 200, body: xml_fixture('response/create_order/valid'))

    # CreateOrder with wrong retailer_id
    stub_request(:post, CONFIG['endpoint'])
      .with(body: xml_fixture('request/create_order/wrong_retailer_id'))
      .to_return(status: 200, body: xml_fixture('response/create_order/wrong_retailer_id'))


    ############################################################
    # cancel_order_spec.rb
    ############################################################

    # CancelOrder with wrong order_id
    stub_request(:post, CONFIG['endpoint'])
      .with(body: xml_fixture('request/cancel_order/wrong_order_id'))
      .to_return(status: 200, body: xml_fixture('response/cancel_order/wrong_order_id'))

    # Can cancel an order
    stub_request(:post, CONFIG['endpoint'])
      .with(body: xml_fixture('request/cancel_order/valid'))
      .to_return(status: 200, body: xml_fixture('response/cancel_order/valid'))

    # Can not cancel an non cancelable order
    stub_request(:post, CONFIG['endpoint'])
      .with(body: xml_fixture('request/cancel_order/non_cancelable'))
      .to_return(status: 200, body: xml_fixture('response/cancel_order/non_cancelable'))

    # Can not cancel an already canceled order
    stub_request(:post, CONFIG['endpoint'])
      .with(body: xml_fixture('request/cancel_order/already_canceled'))
      .to_return(status: 200, body: xml_fixture('response/cancel_order/already_canceled'))
  end
end
