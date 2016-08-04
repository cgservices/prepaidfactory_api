module PrepaidfactoryApi
  module Entities
    # Order entity class
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
        @vouchers = order[:consumer_service_vouchers].values if order[:consumer_service_vouchers].respond_to?(:values)
        @status = order[:status]
      end
    end
  end
end
