module PrepaidfactoryApi

  module Responses
    class CancelOrder < Responses::Base
      def initialize(response)
        response = response[:cancel_order_response]
        Validator.validate_status response[:cancel_order_result]
        super response
      end

      def parse(response)
        @entities << PrepaidfactoryApi::Entities::Order.new({status:'OrderCanceled'})
      end
    end
  end
end
