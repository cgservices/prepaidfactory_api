module PrepaidfactoryApi

  module Responses
    class CancelOrder < Responses::Base

      def parse_response(response)
        puts response
      end

    end
  end
end
