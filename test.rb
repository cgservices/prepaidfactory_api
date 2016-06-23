$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'prepaidfactory_api'

# Load config
config = YAML.load(File.open('./config/ppf_config.yml'))

# Setup client
client = PrepaidfactoryApi::Client.new(config)

# Initiate request
request = PrepaidfactoryApi::Request::GetProductInformation.new(config['ppf']['retailerId'])
products = client.getProductInformation(request)
puts products.
