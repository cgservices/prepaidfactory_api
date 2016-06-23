module PrepaidfactoryApi

  module Responses
    class Product < Responses::Base

      def initialize(retailerID)
        @Name
        @ProductID
        @Description
        @Value
        @EANCode
        @ActivationInstructions
      end

    end
  end
end
