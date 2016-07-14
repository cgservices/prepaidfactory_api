module PrepaidfactoryApi
  module Requests
    # GetProductInformation request class
    class GetProductInformation < Requests::Base
      def initialize(retailer_id)
        @RetailerID = retailer_id
      end
    end
  end
end
