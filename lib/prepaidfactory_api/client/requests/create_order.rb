module PrepaidfactoryApi

  module Requests
    class CreateOrder < Requests::Base

      def initialize(retailerID, productID, terminalID, nrOfVouchers=1, reference='', isCancelable=true, autoConfirm=true)
        @RetailerID = retailerID
        @ProductID = productID
        @TerminalID = terminalID
        @NrOfVouchers = nrOfVouchers
        @Reference = reference
        @IsCancelable = isCancelable
        @AutoConfirm = autoConfirm
      end

    end
  end
end
