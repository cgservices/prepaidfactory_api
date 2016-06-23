module PrepaidfactoryApi

  module Request
    class CreateOrder < Request::Base
      @IsCancelable
      @AutoConfirm
      @RetailerID
      @ProductID
      @TerminalID
      @Reference
      @NrOfVouchers
    end
  end
end
