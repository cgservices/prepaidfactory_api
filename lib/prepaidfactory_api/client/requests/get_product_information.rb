module PrepaidfactoryApi

  module Requests
    class GetProductInformation < Requests::Base

      def initialize(retailerID)
        @RetailerID = retailerID
      end

    end
  end
end
