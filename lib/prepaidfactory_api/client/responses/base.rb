module PrepaidfactoryApi

  module Responses
    class Base < PrepaidfactoryApi::Base
      include Enumerable

      attr_reader :entities

      def initialize(response)
        @entities ||= Array.new
        parse response
      end

      def parse(response)
      end

      def each(&block)
        @entities.each(&block)
      end

    end
  end
end
