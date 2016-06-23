$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'prepaidfactory_api'

# Load config
config = YAML.load(File.open('./config/ppf_config.yml'))

# Setup client
client = PrepaidfactoryApi::Client.new(config)

# Retrieve products
request = PrepaidfactoryApi::Requests::GetProductInformation.new(config['ppf']['retailerId'])
products = client.getProductInformation(request)

# Create order
request = PrepaidfactoryApi::Requests::CreateOrder.new(config['ppf']['retailerId'], 'CS40', 'TEST-TERMINAL')
order = client.createOrder(request)

# Cancel order
request = PrepaidfactoryApi::Requests::CancelOrder.new(order.OrderID)
order = client.cancelOrder(request)

# Confirm order
request = PrepaidfactoryApi::Requests::ConfirmOrder.new(order.OrderId)
order = client.createOrder(request)
