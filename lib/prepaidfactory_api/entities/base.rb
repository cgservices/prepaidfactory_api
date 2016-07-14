module PrepaidfactoryApi
  module Entities
    # Base class for Entities
    class Base < PrepaidfactoryApi::Base
      def each(&block)
        to_hash.each(&block)
      end
    end
  end
end
