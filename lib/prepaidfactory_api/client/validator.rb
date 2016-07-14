module PrepaidfactoryApi
  # Validator class to validate the response status
  class Validator
    def self.confirm_request(got, expected)
      raise PrepaidfactoryApi::MalformedRequest,
            "Request object doesn\'t match operation. Expected '#{expected.name}', got '#{got.class}'" unless got.is_a?(expected)
    end

    def self.validate_status(status)
      case status
      when 'Successful', 'OrderCreated', 'OrderConfirmed', 'OrderCancelled'
        return true
      when 'Error_RetailerNotFound'
        raise PrepaidfactoryApi::RetailerNotFound,
              'An invalid retailer id is provided in the request'
      when 'TerminalLimitExceeded'
        raise PrepaidfactoryApi::TerminalLimitExceeded,
              'Limit per TerminalID exceeded for paysafe products'
      when 'Error_ProductNotFound'
        raise PrepaidfactoryApi::ProductNotFound,
              'The product is unknown or the product won’t be sold anymore'
      when 'Error_OutOfStock'
        raise PrepaidfactoryApi::OutOfStock,
              'The order can’t be created because the requested product is out of stock'
      when 'Error_OrderNotFound'
        raise PrepaidfactoryApi::OrderNotFound,
              'The order could not be found with the supplied order id'
      when 'Error_CancelOrderNotFound'
        raise PrepaidfactoryApi::CancelOrderNotFound,
              'The order to cancel could not be found with the supplied order id'
      when 'Error_ConfirmNotAllowed'
        raise PrepaidfactoryApi::ConfirmNotAllowed,
              'That is because the element IsCancelable was not provided in the CreateOrder request or the element contained the value \'false\''
      when 'Error_InvalidRequestType'
        raise PrepaidfactoryApi::InvalidRequestType,
              'The order could not be confirmed. Please contact PPF when you receive this response'
      when 'Error_CancelOrderNotCancelable'
        raise PrepaidfactoryApi::CancelOrderNotCancelable,
              'The order could not be cancelled, the element IsCancelable was not provided in the CreateOrder request or the element contained the value \'false\''
      when 'Error_CancelOrderNotOpen'
        raise PrepaidfactoryApi::CancelOrderNotOpen,
              'The order could not be cancelled, the order has already been confirmed'
      when 'Error_eVoucherError'
        raise PrepaidfactoryApi::GenericException,
              'Generic exception occurred, please contact PPF and provide the product ID when you receive this response. The product doesn\'t exist with the provider, most likely'
      else
        raise PrepaidfactoryApi::UnknownStatus,
              "An unknown status has been returned: #{status}"
      end
    end
  end
end
