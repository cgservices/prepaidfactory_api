module PrepaidfactoryApi
  module Responses
    # Base class for Responses
    class Base < PrepaidfactoryApi::Base
      attr_reader :entities

      def initialize(response)
        @entities ||= []
        parse response
      end

      def parse(response)
        raise PrepaidfactoryApi::NotImplemented, 'This response object uses the default parse method but it should implement it\'s own'
      end

      def each(&block)
        @entities.each(&block)
      end

      def first
        @entities.first
      end
    end
  end
end
