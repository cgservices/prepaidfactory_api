module PrepaidfactoryApi
  module Responses
    class GetProductInformation < Responses::Base
      def initialize(response)
        response = response[:get_product_information_response][:consumer_service_response]
        Validator.validate_status response[:status]
        super response[:consumer_service_response_product][:consumer_service_product]
      end

      def parse(response)
        response.each { |product|
          @entities << PrepaidfactoryApi::Entities::Product.new(product)
        }
      end
    end
  end
end
