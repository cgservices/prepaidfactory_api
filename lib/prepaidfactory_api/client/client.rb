require 'OpenSSL'
require 'savon'

module PrepaidfactoryApi

  class Client

    def initialize(config)
      config['soap']['open_timeout'] ||= 1
      config['soap']['read_timeout'] ||= 5
      @@config = config
      setup
    end

    def setup
      raise SecurityError, "Certificate doesn't exists" unless File.exists?(@@config['certificate']['pem_cert'])
      raise SecurityError, "Certificate key doesn't exists" unless File.exists?(@@config['certificate']['pem_key'])

      return @@soap = Savon.client({
        endpoint:                 @@config['soap']['endpoint'],
        wsdl:                     @@config['soap']['wsdl'],
        #namespace:                'http://www.w3.org/2003/05/soap/',
        namespace_identifier:     :tns,
        #ssl_cert_file:            OpenSSL::X509::Certificate.new(File.read(@_sCertificate)),
        ssl_cert_file:            @@config['certificate']['pem_cert'],
        ssl_cert_key_file:        @@config['certificate']['pem_key'],
        ssl_cert_key_password:    @@config['certificate']['pem_key_secret'],
        ssl_verify_mode:          :none, # :none SHOULDN'T BE NECESSARY
        log_level:                :debug,
        #log:                      true,
        open_timeout:             @@config['soap']['open_timeout'],
        read_timeout:             @@config['soap']['read_timeout'],
        convert_request_keys_to:  :none,
        soap_header: {
          authentication: {
            "username" => @@config['soap']['username'],
            "password" => @@config['soap']['password']
          }
        }
      })
    end

    def getProductInformation(request)
      request(:get_product_information, request)
    end

    def createOrder(request)
      request(:create_order, request)
    end

    def confirmOrder(request)
      request(:confirm_order, request)
    end

    def cancelOrder(request)
      response = request(:cancel_order, request)
    end

    private

    def request(operation, request)
      begin
        response = @@soap.call(operation, :message => request.to_hash)
      rescue Savon::HTTPError => e
        raise PrepaidfactoryApi::Exception.new(e), "HTTP error, is the setup correct and the endpoint online?"
      rescue Savon::SOAPFault => e
        raise PrepaidfactoryApi::Exception.new(e), "SOAPFault caught, the message is [#{e.to_hash[:fault][:faultcode]}] #{e.to_hash[:fault][:faultstring]}"
      rescue => e
        raise PrepaidfactoryApi::Exception.new(e), "Uncaught error on operation '#{operation.to_s}': #{e.message}"
      end

      parse_response(response.body, operation)
    end

    def parse_response(response, operation)
      response = response[:"#{operation}_response"][:consumer_service_response]
      status = response[:status]
      puts "#{operation.to_s.ljust(30)}: #{status}"

      # Parse response status
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

      map_to_object(response)
    end

    def map_to_object(response)
      response_name = response.keys[1].to_s.sub('consumer_service_response_','')
      object_name = "PrepaidfactoryApi::Responses::#{response_name.capitalize}"
      response = response[:"consumer_service_response_#{response_name}"]
      puts "#{object_name} => #{response.size}"
    end

  end
end
