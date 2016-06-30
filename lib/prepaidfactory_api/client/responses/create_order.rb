module PrepaidfactoryApi

  module Responses
    class CreateOrder < Responses::Base

      def initialize(response)
        response = response[:create_order_response][:"consumer_service_response"]
        Exception.check response[:status]
        super response[:consumer_service_response_order][:consumer_service_order]
      end

      def parse(response)
        @entities.push PrepaidfactoryApi::Entities::Order.new(response)
      end

    end
  end
end
