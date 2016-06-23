module PrepaidfactoryApi

  module Responses
    class CreateOrder < Responses::Base

      def initialize(retailerID, productID, terminalID, nrOfVouchers=1, reference='', isCancelable=true, autoConfirm=true)
        @OrderID
        @TerminalID
        @Reference
        @OrderDate
        @Currency
        @ProviderName
        @ProductId
        @EANCode
        @PromotionText
        @ActivationInstructions
        @Vouchers = [{
          SerialNumber: '',
          ActivationCode: '',
          ExpiryDate: ''
        }]
      end

    end
  end
end
