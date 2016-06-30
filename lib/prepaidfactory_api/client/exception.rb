module PrepaidfactoryApi

  class Exception < StandardError
    attr_reader :object

    def initialize(object)
      @object = object
      super
    end

    def self.check(status)
      case status
      when "Error_RetailerNotFound"
        raise PrepaidfactoryApi::Exception, "An invalid retailer id is provided in the request"
      when "Error_NoCredit"
        raise PrepaidfactoryApi::Exception, "The order could not be created, when you receive this status there is no credit left"
      when "TerminalLimitExceeded"
        raise PrepaidfactoryApi::Exception, "Limit per TerminalID exceeded for paysafe products "
      when "Error_ProductNotFound"
        raise PrepaidfactoryApi::Exception, "The product is unknown or the product won’t be sold anymore"
      when "Error_OutOfStock"
        raise PrepaidfactoryApi::Exception, "The order can’t be created because the requested product is out of stock"
      when "Error_OrderNotFound", "Error_CancelOrderNotFound"
        raise PrepaidfactoryApi::Exception, "The order could not be found with the supplied order id"
      when "Error_ConfirmNotAllowed"
        raise PrepaidfactoryApi::Exception, "That is because the element IsCancelable was not provided in the CreateOrder request or the element contained the value 'false'"
      when "Error_InvalidRequestType"
        raise PrepaidfactoryApi::Exception, "The order could not be confirmed. Please contact PPF when you receive this response"
      when "Error_CancelOrderNotCancelable"
        raise PrepaidfactoryApi::Exception, "The order could not be cancelled, the element IsCancelable was not provided in the CreateOrder request or the element contained the value 'false'"
      when "Error_CancelOrderNotOpen"
        raise PrepaidfactoryApi::Exception, "The order could not be cancelled, the order has already been confirmed"
      end
    end

  end
end
