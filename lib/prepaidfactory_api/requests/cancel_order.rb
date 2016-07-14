module PrepaidfactoryApi
  module Requests
    # CancelOrder request class
    class CancelOrder < Requests::Base
      def initialize(order_id)
        @OrderID = order_id
      end
    end
  end
end
