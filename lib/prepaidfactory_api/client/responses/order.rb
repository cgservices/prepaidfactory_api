module PrepaidfactoryApi

  module Responses
    class Order < Responses::Base

      def initialize(response)
        @entities ||= Array.new
        super response[:"consumer_service_order"]
      end

      def parse(response)
        @entities.push PrepaidfactoryApi::Entities::Order.new(response)
      end

    end
  end
end
