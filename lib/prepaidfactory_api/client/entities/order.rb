module PrepaidfactoryApi

  module Entities
    class Order < Entities::Base

      attr_reader :order_id, :terminal_id, :reference, :order_date, :currency, :provider_name, :product_id, :eancode, :promotion_text, :activation_instructions, :vouchers, :status

      def initialize(order)
        @order_id = order[:order_id]
        @terminal_id = order[:terminal_id]
        @reference = order[:reference]
        @order_date = order[:order_date]
        @currency = order[:currency]
        @provider_name = order[:provider_name]
        @product_id = order[:product_id]
        @eancode = order[:eancode]
        @promotion_text = order[:promotion_text]
        @activation_instructions = order[:activation_instructions]
        @vouchers = order[:vouchers]
        @status = order[:status]
      end

    end
  end
end
