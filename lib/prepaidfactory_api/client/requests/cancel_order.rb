module PrepaidfactoryApi

  module Requests
    class CancelOrder < Requests::Base

      def initialize(orderID)
        @OrderID = orderID
      end

    end
  end
end
