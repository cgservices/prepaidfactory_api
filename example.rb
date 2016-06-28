$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'prepaidfactory_api'

# Load config
config = YAML.load(File.open('./config/ppf_config.yml'))

# Setup client
client = PrepaidfactoryApi::Client.new(config)

# Retrieve products
# request = PrepaidfactoryApi::Requests::GetProductInformation.new(config['ppf']['retailerId'])
# products = client.getProductInformation(request)
# products.entities.each { |product|
#   product.instance_variables.each { |key, value|
#     puts "#{key.to_s.delete('@').ljust(25)}: #{product.instance_variable_get(key)}"
#   }
#   puts "========================================================================="
# }

# Create order
# request = PrepaidfactoryApi::Requests::CreateOrder.new(config['ppf']['retailerId'], 'C3627', 'TEST-TERMINAL')
# orders = client.createOrder(request)
# order = orders.entities.first
# order.instance_variables.each { |key, value|
#   puts "#{key.to_s.delete('@').ljust(25)}: #{order.instance_variable_get(key)}"
# }

# Cancel order
order_id = '5689';
request = PrepaidfactoryApi::Requests::CancelOrder.new(order_id)
cancel_order = client.cancelOrder(request)
#puts cancel_order.class

# Confirm order
#request = PrepaidfactoryApi::Requests::ConfirmOrder.new(order.OrderId)
#order = client.confirmOrder(request)
