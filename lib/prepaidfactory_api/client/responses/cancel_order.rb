module PrepaidfactoryApi

  module Responses
    class CancelOrder < Responses::Base

      def initialize(cancelOrderResult)
        @CancelOrderResult = cancelOrderResult
      end

    end
  end
end
