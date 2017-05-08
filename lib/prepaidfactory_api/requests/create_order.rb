module PrepaidfactoryApi
  module Requests
    # CreateOrder request class
    class CreateOrder < Requests::Base
      def initialize(retailer_id, product_id, terminal_id, nr_of_vouchers=1, reference='', is_cancelable=true, auto_confirm=false)
        @RetailerID = retailer_id
        @ProductID = product_id
        @TerminalID = terminal_id
        @NrOfVouchers = nr_of_vouchers
        @Reference = reference
        @IsCancelable = is_cancelable
        @AutoConfirm = auto_confirm
      end
    end
  end
end
