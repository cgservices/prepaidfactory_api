$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'prepaidfactory_api'

# Load config
config = YAML.load(File.open('./config/ppf_config.yml'))

# Setup client
client = PrepaidfactoryApi::Client.new(config)

# Retrieve products
request = PrepaidfactoryApi::Requests::GetProductInformation.new(config['retailer_id'])
products = client.getProductInformation(request)

product_id = ''
products.each { |product|
  puts "#{product.product_id}: #{product.description}"
  # product_id = product.product_id
  # product.each { |key, value|
  #  puts "#{key.to_s.delete('@').ljust(25)}: #{product.instance_variable_get(key)}"
  # }
  # puts "========================================================================="
}

# Create order
puts "\n==============================================================\nCREATING ORDER FOR #{product_id}\n=============================================================="
request = PrepaidfactoryApi::Requests::CreateOrder.new(config['retailer_id'], 'C9910', 'TEST-TERMINAL')
order = client.createOrder(request)
order.each { |key, value|
  puts "#{key.to_s.delete('@').ljust(25)}: #{order.instance_variable_get(key)}"
}

# Cancel order
# puts "\n==============================================================\nCANCEL ORDER\n=============================================================="
# request = PrepaidfactoryApi::Requests::CancelOrder.new(order.order_id)
# p client.cancelOrder(request)

# Confirm order
# puts "\n==============================================================\nCONFIRM ORDER #{order.order_id}\n=============================================================="
# request = PrepaidfactoryApi::Requests::ConfirmOrder.new(order.order_id)
# order = client.confirmOrder(request)
# order.each { |key, value|
#   puts "#{key.to_s.delete('@').ljust(25)}: #{order.instance_variable_get(key)}"
# }
