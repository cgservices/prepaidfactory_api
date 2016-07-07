module PrepaidfactoryApi

  WrongRequestObject        = Class.new(TypeError)
  Error                     = Class.new(RuntimeError)
  UnknownStatus             = Class.new(Error)
  MalformedRequestObject    = Class.new(Error)
  HTTPError                 = Class.new(Error)
  SOAPFault                 = Class.new(Error)
  UnknownOperation          = Class.new(Error)
  Uncaught                  = Class.new(Error)
  RetailerNotFound          = Class.new(Error)
  NoCredit                  = Class.new(Error)
  TerminalLimitExceeded     = Class.new(Error)
  ProductNotFound           = Class.new(Error)
  OutOfStock                = Class.new(Error)
  OrderNotFound             = Class.new(Error)
  ConfirmNotAllowed         = Class.new(Error)
  InvalidRequestType        = Class.new(Error)
  CancelOrderNotFound       = Class.new(Error)
  CancelOrderNotCancelable  = Class.new(Error)
  CancelOrderNotOpen        = Class.new(Error)

  class Exception < StandardError

    attr_reader :object

    def initialize(object)
      @object = object
      super
    end

    def self.confirm_request(got, expected)
      raise PrepaidfactoryApi::WrongRequestObject, "Expected #{expected.class}, got #{got.class}" unless got.kind_of?(expected)
    end

    def self.check(status)
      case status
      when "OrderCreated", "OrderConfirmed","OrderCancelled"
        return
      when "Error_RetailerNotFound"
        raise PrepaidfactoryApi::RetailerNotFound, "An invalid retailer id is provided in the request"
      when "Error_NoCredit"
        raise PrepaidfactoryApi::NoCredit, "The order could not be created, when you receive this status there is no credit left"
      when "TerminalLimitExceeded"
        raise PrepaidfactoryApi::TerminalLimitExceeded, "Limit per TerminalID exceeded for paysafe products"
      when "Error_ProductNotFound"
        raise PrepaidfactoryApi::ProductNotFound, "The product is unknown or the product won’t be sold anymore"
      when "Error_OutOfStock"
        raise PrepaidfactoryApi::OutOfStock, "The order can’t be created because the requested product is out of stock"
      when "Error_OrderNotFound"
        raise PrepaidfactoryApi::OrderNotFound, "The order could not be found with the supplied order id"
      when "Error_CancelOrderNotFound"
        raise PrepaidfactoryApi::CancelOrderNotFound, "The order to cancel could not be found with the supplied order id"
      when "Error_ConfirmNotAllowed"
        raise PrepaidfactoryApi::ConfirmNotAllowed, "That is because the element IsCancelable was not provided in the CreateOrder request or the element contained the value 'false'"
      when "Error_InvalidRequestType"
        raise PrepaidfactoryApi::InvalidRequestType, "The order could not be confirmed. Please contact PPF when you receive this response"
      when "Error_CancelOrderNotCancelable"
        raise PrepaidfactoryApi::CancelOrderNotCancelable, "The order could not be cancelled, the element IsCancelable was not provided in the CreateOrder request or the element contained the value 'false'"
      when "Error_CancelOrderNotOpen"
        raise PrepaidfactoryApi::CancelOrderNotOpen, "The order could not be cancelled, the order has already been confirmed"
      else
        raise PrepaidfactoryApi::UnknownStatus, "An unknown status has been returned: #{status}"
      end
    end

  end
end
