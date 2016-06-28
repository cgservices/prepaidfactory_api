module PrepaidfactoryApi

  module Responses
    class Base < PrepaidfactoryApi::Base

      attr_reader :entities

      def initialize(response)
        @entities ||= Array.new
        parse response
      end

      def parse(response) end

    end
  end
end
