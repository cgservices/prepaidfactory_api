module PrepaidfactoryApi

  module Responses
    class Product < Responses::Base

      def initialize(response)
        super response[:"consumer_service_product"]
      end

      def parse(response)
        response.each { |product|
          @entities.push PrepaidfactoryApi::Entities::Product.new(product)
        }
      end

    end
  end
end
