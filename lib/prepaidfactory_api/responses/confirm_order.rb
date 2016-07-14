module PrepaidfactoryApi
  module Responses
    class ConfirmOrder < Responses::Base
      def initialize(response)
        response = response[:confirm_order_response][:consumer_service_response]
        Validator.validate_status response[:status]
        super response
      end

      def parse(response)
        response[:consumer_service_response_order][:consumer_service_order][:status] = response[:status]
        @entities << PrepaidfactoryApi::Entities::Order.new(response[:consumer_service_response_order][:consumer_service_order])
      end
    end
  end
end
