module PrepaidfactoryApi

  module Entities
    class Base < PrepaidfactoryApi::Base

      def each(&block)
        self.instance_variables.each(&block)
      end

    end
  end
end
