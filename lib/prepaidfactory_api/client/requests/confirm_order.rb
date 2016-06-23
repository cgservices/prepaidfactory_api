module PrepaidfactoryApi

  module Requests
    class ConfirmOrder < Requests::Base

      def initialize(orderID)
        @OrderID = orderID
      end

    end
  end
end
