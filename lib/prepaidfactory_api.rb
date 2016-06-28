require 'yaml'

# Prepaid Factory API
require 'prepaidfactory_api/base'
require 'prepaidfactory_api/version'

# Prepadi Factory client
require 'prepaidfactory_api/client/exception'
require 'prepaidfactory_api/client/client'

# Request objects
require 'prepaidfactory_api/client/requests/base'
require 'prepaidfactory_api/client/requests/get_product_information'
require 'prepaidfactory_api/client/requests/create_order'
require 'prepaidfactory_api/client/requests/cancel_order'
require 'prepaidfactory_api/client/requests/confirm_order'

# Response objects
require 'prepaidfactory_api/client/responses/base'
require 'prepaidfactory_api/client/responses/cancel_order'
require 'prepaidfactory_api/client/responses/order'
require 'prepaidfactory_api/client/responses/product'

# Entities
require 'prepaidfactory_api/client/entities/base'
require 'prepaidfactory_api/client/entities/order'
require 'prepaidfactory_api/client/entities/product'

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
