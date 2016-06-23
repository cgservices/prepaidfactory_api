module PrepaidfactoryApi

  module Request
    class GetProductInformation < Request::Base

      def initialize(retailerId)
        @RetailerID = retailerId
      end
    end
  end
end
