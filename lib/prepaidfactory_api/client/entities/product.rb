module PrepaidfactoryApi

  module Entities
    class Product < Entities::Base

      attr_reader :provider_name, :product_id, :description, :value, :eancode, :activation_instructions

      def initialize(product)
        @provider_name = product[:provider_name]
        @product_id = product[:product_id]
        @description = product[:description]
        @value = product[:value]
        @eancode = product[:eancode]
        @activation_instructions = product[:activation_instructions]
      end

    end
  end
end
