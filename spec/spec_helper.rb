ENV['RAILS_ENV'] ||= 'test'

# Set load path
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

# Setup WebMock, disable this for integration test
require 'webmock/rspec'
require 'support/fake_ppf'
WebMock.disable_net_connect!(allow_localhost: true)

# Require Pry for debugging
require 'pry'

# Setup code coverage
require 'simplecov'
SimpleCov.start

# Require Prepaid Factory API
require 'prepaidfactory_api'
CONFIG = YAML.load(File.open('./config/development/ppf_config.yml'))
CLIENT = PrepaidfactoryApi::Client.new(CONFIG)
TERMINAL = '93880010'.freeze

# Require PrepaidFactory stubs/mocks
require 'support/prepaidfactory_api/requests/fake_request'
require 'support/prepaidfactory_api/requests/wrong_request'

# Configure RSpec
RSpec.configure do |config|
  config.color = true
  config.fail_fast = ENV['FAIL_FAST'] || false
  # config.order = 'random'
end

# Define different kinds of testproducts, the currently available
# products are listed below.
PRODUCT = 'H0201'.freeze
# PRODUCT_WITH_LIMIT = 'C3900'.freeze
# PRODUCT_NOT_FOUND = 'SSC40'.freeze
# PRODUCT_OUT_OF_STOCK = 'SSC50'.freeze
