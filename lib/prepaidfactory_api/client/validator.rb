module PrepaidfactoryApi
  # Validator class to validate the response status
  class Validator
    def self.confirm_request(got, expected)
      raise PrepaidfactoryApi::OperationMalformedRequest,
            "Request object doesn't match operation. Expected '#{expected.name}', got '#{got.class}'" unless got.is_a?(expected)
      raise PrepaidfactoryApi::OperationUnknownRequestObject,
            'Request object is unknown and cannot be used for this request' unless got.respond_to?(:to_hash)
    end

    def self.validate_status(status)
      case status
      when 'Successful', 'OrderCreated', 'OrderConfirmed', 'OrderCancelled'
        return true
      when 'Error_RetailerNotFound'
        raise PrepaidfactoryApi::OperationRetailerNotFound,
              'An invalid retailer id is provided in the request'
      when 'TerminalLimitExceeded'
        raise PrepaidfactoryApi::OperationTerminalLimitExceeded,
              'Limit per TerminalID exceeded'
      when 'Error_ProductNotFound'
        raise PrepaidfactoryApi::OperationProductNotFound,
              'The product is unknown or the product won’t be sold anymore'
      when 'Error_OutOfStock'
        raise PrepaidfactoryApi::OperationOutOfStock,
              'The order can’t be created because the requested product is out of stock'
      when 'Error_OrderNotFound'
        raise PrepaidfactoryApi::OperationOrderNotFound,
              'The order could not be found with the supplied order id'
      when 'Error_CancelOrderNotFound'
        raise PrepaidfactoryApi::OperationCancelOrderNotFound,
              'The order to cancel could not be found with the supplied order id'
      when 'Error_ConfirmNotAllowed'
        raise PrepaidfactoryApi::OperationConfirmNotAllowed,
              'That is because the element IsCancelable was not provided in the CreateOrder request or the element contained the value \'false\''
      when 'Error_InvalidRequestType'
        raise PrepaidfactoryApi::OperationInvalidRequestType,
              'The order could not be confirmed. Please contact PPF when you receive this response'
      when 'Error_CancelOrderNotCancelable'
        raise PrepaidfactoryApi::OperationCancelOrderNotCancelable,
              'The order could not be cancelled, the element IsCancelable was not provided in the CreateOrder request or the element contained the value \'false\''
      when 'Error_CancelOrderNotOpen'
        raise PrepaidfactoryApi::OperationCancelOrderNotOpen,
              'The order could not be cancelled, the order has already been confirmed'
      when 'Error_eVoucherError'
        raise PrepaidfactoryApi::OperationGenericException,
              'Generic exception occurred, please contact PPF and provide the product ID when you receive this response. The product doesn\'t exist with the provider, most likely'
      else
        raise PrepaidfactoryApi::OperationUnknownStatus,
              "An unknown status has been returned: #{status}"
      end
    end
  end
end
