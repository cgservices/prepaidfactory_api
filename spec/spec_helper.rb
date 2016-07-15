# Set load path
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

# Setup code coverage
require 'simplecov'
SimpleCov.start

# Require Prepaid Factory API
require 'prepaidfactory_api'

# Create test classes
module PrepaidfactoryApi
  module Requests
    # FakeRequest class, used for testing
    class FakeRequest
    end

    # WrongRequest class, used for testing
    class WrongRequest < PrepaidfactoryApi::Requests::Base
    end
  end
end

# Define different kinds of testproducts, the currently available
# products are listed below.
#
# C3900: PAYSAFE 10 EURO
# C3901: PAYSAFE 25 EURO
# C3902: PAYSAFE 50 EURO
# C3903: PAYSAFE 100 EURO
# C3638: DELIGHT10
# C3639: DELIGHT20
# C3636: VECTONE 10 EURO
# C3637: VECTONE 20 EURO
# C3659: LYCA DATA 10 EURO
# C3656: LYCAMOBILE 10 EURO
# C3657: LYCAMOBILE 20 EURO
# C3658: LYCA HOLLAND BUNDEL
# C3626: BUDGET PHONE 5 EURO
# C3627: BUDGET PHONE 10
# C3628: BUDGET PHONE 20
# C3629: BUDGET PHONE 50
# C3633: T-MOBILE 10 EURO
# C3614: T-MOBILE 15 EURO
# C3634: T-MOBILE 20 EURO
# C3635: T-MOBILE 40 EURO
# C3615: VODAFONE 10 EURO
# C3623: VODAFONE 20 EURO
# C3624: VODAFONE 30 EURO
# C3625: VODAFONE 40 EURO
# SSC10: SSC 10 euro, max field length
# SSC20: SSC 20 euro, different instructions on every call
# SSC30: SSC 30 euro, returns error not found on cancelation or confirmation
# SSC40: SSC 40 euro, returns error not found on order creation
# SSC50: SSC 50 euro, always returns out of stock
PRODUCT = 'C3624'.freeze
PRODUCT_WITH_LIMIT = 'C3900'.freeze
PRODUCT_NOT_FOUND = 'SSC40'.freeze
PRODUCT_OUT_OF_STOCK = 'SSC50'.freeze

# Define config and client
CONFIG = YAML.load(File.open('./config/ppf_config.yml'))
CLIENT = PrepaidfactoryApi::Client.new(CONFIG)
TERMINAL = 'RSPEC_TEST1'.freeze
