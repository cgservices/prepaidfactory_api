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
      object = request(:create_order, request)
      object.entities.first
    end

    def confirmOrder(request)
      object = request(:confirm_order, request)
      object.entities.first
    end

    def cancelOrder(request)
      request(:cancel_order, request)
    end

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

      response_to_object operation, response.body
    end

    def response_to_object(operation, response)
      class_operation = operation.to_s.split('_').map{|s| s.capitalize }.join
      response_class = "PrepaidfactoryApi::Responses::#{class_operation}".split('::').inject(Object) {|object, const| object.const_get const}
      response_object = response_class.new(response)
    end

  end
end
