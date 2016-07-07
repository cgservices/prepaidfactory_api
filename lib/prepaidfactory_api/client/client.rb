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

    def getProductInformation(request_object)
      Exception.confirm_request request_object, PrepaidfactoryApi::Requests::GetProductInformation
      request(:get_product_information, request_object)
    end

    def createOrder(request_object)
      Exception.confirm_request request_object, PrepaidfactoryApi::Requests::CreateOrder
      object = request(:create_order, request_object)
      object.entities.first
    end

    def confirmOrder(request_object)
      Exception.confirm_request request_object, PrepaidfactoryApi::Requests::ConfirmOrder
      object = request(:confirm_order, request_object)
      object.entities.first
    end

    def cancelOrder(request_object)
      Exception.confirm_request request_object, PrepaidfactoryApi::Requests::CancelOrder
      object = request(:cancel_order, request_object)
      object.entities.first
    end

    def request(operation, request_object)
      p request_object.to_hash
      raise PrepaidfactoryApi::MalformedRequestObject, "Malformed request object #{request_object.class} for operation #{operation.to_s}" unless request_object.respond_to?(:to_hash)

      begin
        response = @@soap.call(operation, message: request_object.to_hash)
      rescue Savon::HTTPError => e
        raise PrepaidfactoryApi::HTTPError, "HTTP error, is the setup correct and the endpoint online?"
      rescue Savon::SOAPFault => e
        raise PrepaidfactoryApi::SOAPFault, "SOAPFault caught, the message is [#{e.to_hash[:fault][:faultcode]}] #{e.to_hash[:fault][:faultstring]}"
      rescue Savon::UnknownOperationError => e
        raise PrepaidfactoryApi::UnknownOperation, "Unknown operation '#{operation.to_s}', the message is #{e}"
      rescue => e
        raise PrepaidfactoryApi::Uncaught, "Uncaught error on operation '#{operation.to_s}': #{e.message}"
      end

      response_to_object operation, response.body
    end

    def response_to_object(operation, response)
      class_operation = operation.to_s.split('_').map{|s| s.capitalize }.join
      response_class = "PrepaidfactoryApi::Responses::#{class_operation}".split('::').inject(Object) {|object, const| object.const_get const}
      response_object = response_class.new(response)
    end

  end
end
