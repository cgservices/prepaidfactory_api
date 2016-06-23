require 'yaml'

# Prepaid Factory API
require 'prepaidfactory_api/version'
require 'prepaidfactory_api/client/exception'
require 'prepaidfactory_api/client/client'
#require 'prepaidfactory_api/client/product'
#require 'prepaidfactory_api/client/order'

# Request objects
require 'prepaidfactory_api/client/requests/base'
require 'prepaidfactory_api/client/requests/get_product_information'
require 'prepaidfactory_api/client/requests/create_order'
require 'prepaidfactory_api/client/requests/cancel_order'
require 'prepaidfactory_api/client/requests/confirm_order'

# config
#config = YAML.load(File.open('./config/ppf_config.yml'))

# Create client instance
#client = PrepaidfactoryApi::Client.new(config)

# Retrieve products
#request = PrepaidfactoryApi::Request::GetProductInformation.new(config['ppf']['retailerId'])
#products = client.getProductInformation()
#products.each { |product|
#  puts product.to_s
#}

# Create new order
#client.createOrder(PrepaidfactoryApi::Request::CreateOrder.new)
