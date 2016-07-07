module PrepaidfactoryApi

  module Responses
    class Base < PrepaidfactoryApi::Base
      #include Enumerable

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

      def first
        @entities.first
      end

      def method_missing(method, *args, &block)
        @entities.first.send(method.to_sym, *args)
      end

    end
  end
end
