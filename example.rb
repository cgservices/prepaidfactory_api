$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'prepaidfactory_api'

# Load config
config = YAML.load(File.open('./config/ppf_config.yml'))

# Setup client
client = PrepaidfactoryApi::Client.new(config)

# Retrieve products
puts "\n=============================================================="
puts ' RETRIEVE PRODUCTS'
puts '=============================================================='
request = PrepaidfactoryApi::Requests::GetProductInformation.new(config['retailer_id'])
products = client.get_product_information(request)

product_id = ''
products.each { |product|
  puts "#{product.product_id}: #{product.description}"
  product_id = product.product_id
  product.each { |key, value|
    puts "#{key.to_s.ljust(25)}: #{value}"
  }
  puts "\n=============================================================="
}

# Create order
puts "\n=============================================================="
puts " CREATING ORDER FOR #{product_id}"
puts '=============================================================='
# product_id = 'SSC50'
request = PrepaidfactoryApi::Requests::CreateOrder.new(config['retailer_id'], product_id, 'TEST-TERMINAL')
order = client.create_order(request)
order.each { |key, value|
  puts "#{key.to_s.ljust(25)}: #{value}"
}

# Cancel order
# puts "\n=============================================================="
# puts "CANCEL ORDER #{product_id}"
# puts '=============================================================='
# request = PrepaidfactoryApi::Requests::CancelOrder.new(order.order_id)
# p client.cancel_order(request)

# Confirm order
puts "\n=============================================================="
puts "CONFIRM ORDER #{order.order_id}"
puts '=============================================================='
request = PrepaidfactoryApi::Requests::ConfirmOrder.new(order.order_id)
order = client.confirm_order(request)
order.each { |key, value|
  puts "#{key.to_s.ljust(25)}: #{value}"
}
