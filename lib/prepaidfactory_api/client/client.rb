require 'OpenSSL'
require 'savon'

module PrepaidfactoryApi

  class Client

    def initialize(config)
      config['open_timeout'] ||= 1
      config['read_timeout'] ||= 5
      config['ssl_verify_mode'] ||= :peer # :none, :peer, :fail_if_no_peer_cert, :client_once
      @@config = config
      setup
    end

    def setup
      raise PrepaidfactoryApi::NoCertificate, "Certificate doesn't exists" unless File.exists?(@@config['pem_cert'])
      raise PrepaidfactoryApi::NoCertificateKey, "Certificate key doesn't exists" unless File.exists?(@@config['pem_key'])

      return @@soap = Savon.client({
        endpoint:                 @@config['endpoint'],
        wsdl:                     @@config['wsdl'],
        #namespace:                'http://www.w3.org/2003/05/soap/',
        namespace_identifier:     :tns,
        #ssl_cert_file:            OpenSSL::X509::Certificate.new(File.read(@_sCertificate)),
        ssl_cert_file:            @@config['pem_cert'],
        ssl_cert_key_file:        @@config['pem_key'],
        ssl_cert_key_password:    @@config['pem_key_secret'],
        #ssl_verify_mode:          @@config['ssl_verify_mode'], # :none SHOULDN'T BE NECESSARY
        ssl_verify_mode:          :none, # :none SHOULDN'T BE NECESSARY
        log_level:                :debug,
        #log:                      true,
        open_timeout:             @@config['open_timeout'],
        read_timeout:             @@config['read_timeout'],
        convert_request_keys_to:  :none,
        soap_header: {
          authentication: {
            "username" => @@config['username'],
            "password" => @@config['password']
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
      raise PrepaidfactoryApi::MalformedRequestObject, "Malformed request object #{request_object.class} for operation #{operation.to_s}" unless request_object.kind_of?(PrepaidfactoryApi::Requests::Base)

      begin
        response = @@soap.call(operation, message: request_object.to_hash)
      rescue Savon::HTTPError => e
        raise PrepaidfactoryApi::HTTPError, "HTTP error, is the setup correct and the endpoint online?"
      rescue Savon::SOAPFault => e
        case e.to_hash[:fault][:faultcode]
        when "AuthenticationError"
          raise PrepaidfactoryApi::AuthenticationError, "SOAPFault caught, the message is [#{e.to_hash[:fault][:faultcode]}] #{e.to_hash[:fault][:faultstring]}"
        else
          raise PrepaidfactoryApi::SOAPFault, "SOAPFault caught, the message is [#{e.to_hash[:fault][:faultcode]}] #{e.to_hash[:fault][:faultstring]}"
        end
      rescue Savon::UnknownOperationError => e
        raise PrepaidfactoryApi::UnknownOperation, "Unknown operation '#{operation.to_s}', the message is #{e}"
      rescue ArgumentError => e
        raise PrepaidfactoryApi::WrongSetup, "Something seems off with your config '#{operation.to_s}': #{e.message}"
      rescue OpenSSL::X509::CertificateError => e
        raise PrepaidfactoryApi::CertificateError, "There is a problem with the certificates: '#{operation.to_s}': #{e.message}"
      rescue HTTPI::SSLError
        raise PrepaidfactoryApi::SSLError, "Unable to setup a verified SSL connection: '#{operation.to_s}'"
      #rescue => e
      #  raise PrepaidfactoryApi::Uncaught, "Uncaught error on operation '#{operation.to_s}': #{e.message} #{e}"
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
