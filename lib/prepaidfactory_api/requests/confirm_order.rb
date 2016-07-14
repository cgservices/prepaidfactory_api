module PrepaidfactoryApi
  module Requests
    # ConfirmOrder request class
    class ConfirmOrder < Requests::Base
      def initialize(order_id)
        @OrderID = order_id
      end
    end
  end
end
