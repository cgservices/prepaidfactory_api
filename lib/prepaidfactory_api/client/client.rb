require 'OpenSSL'
require 'savon'

module PrepaidfactoryApi
  # This is the Prepaid Factory API client
  class Client
    def initialize(config)
      config['open_timeout'] ||= 1
      config['read_timeout'] ||= 5
      config['ssl_verify_mode'] ||= :peer
      config['ssl_ca_cert_file'] ||= config['pem_cert']
      @config = config
      setup_savon
    end

    private

    def setup_savon
      raise PrepaidfactoryApi::ConnectionNoCertificate, "Certificate doesn't exists" unless File.exist?(@config['pem_cert'])
      raise PrepaidfactoryApi::ConnectionNoCertificateKey, "Certificate key doesn't exists" unless File.exist?(@config['pem_key'])

      @soap = Savon.client(
        endpoint:                 @config['endpoint'],
        wsdl:                     @config['wsdl'],
        namespace_identifier:     :tns,
        ssl_ca_cert_file:         @config['ssl_ca_cert_file'],
        ssl_cert_file:            @config['pem_cert'],
        ssl_cert_key_file:        @config['pem_key'],
        ssl_cert_key_password:    @config['pem_key_secret'],
        open_timeout:             @config['open_timeout'],
        read_timeout:             @config['read_timeout'],
        convert_request_keys_to:  :none,
        soap_header: {
          authentication: {
            'username' => @config['username'],
            'password' => @config['password']
          }
        }
      )
    end

    public

    def get_product_information(request_object)
      Validator.confirm_request request_object, PrepaidfactoryApi::Requests::GetProductInformation
      request(:get_product_information, request_object)
    end

    def create_order(request_object)
      Validator.confirm_request request_object, PrepaidfactoryApi::Requests::CreateOrder
      object = request(:create_order, request_object)
      object.first
    end

    def confirm_order(request_object)
      Validator.confirm_request request_object, PrepaidfactoryApi::Requests::ConfirmOrder
      object = request(:confirm_order, request_object)
      object.first
    end

    def cancel_order(request_object)
      Validator.confirm_request request_object, PrepaidfactoryApi::Requests::CancelOrder
      object = request(:cancel_order, request_object)
      object.first
    end

    def request(operation, request_object)
      begin
        Validator.confirm_request request_object, objectify("PrepaidfactoryApi::Requests::#{camelize operation}")
      rescue PrepaidfactoryApi::OperationUnableToObjectify
        raise PrepaidfactoryApi::OperationUnknownRequestObject,
              "Unable to initialize a PrepaidfactoryApi::Requests::#{camelize operation} request object"
      end

      begin
        response = @soap.call(operation, message: request_object.to_hash)
      rescue Savon::HTTPError => e
        raise PrepaidfactoryApi::ConnectionHTTPError,
              "HTTP error, is the setup correct and the endpoint online? The message is #{e.message}"
      rescue Savon::SOAPFault => e
        case e.to_hash[:fault][:faultcode]
        when 'AuthenticationError'
          raise PrepaidfactoryApi::ConnectionAuthenticationError,
                "SOAPFault caught, the message is [#{e.to_hash[:fault][:faultcode]}] #{e.to_hash[:fault][:faultstring]}"
        else
          raise PrepaidfactoryApi::OperationSOAPFault,
                "SOAPFault caught, the message is [#{e.to_hash[:fault][:faultcode]}] #{e.to_hash[:fault][:faultstring]}"
        end
      rescue Savon::UnknownOperationError, NameError => e
        raise PrepaidfactoryApi::OperationUnknownOperation,
              "Unknown operation '#{operation}', the message is #{e}"
      rescue Net::OpenTimeout, SocketError => e
        raise PrepaidfactoryApi::ConnectionEndpointUnavailable,
              'A timeout occurred while connecting to the endpoint'
      rescue ArgumentError => e
        case e.message.strip
        when 'Invalid URL:'
          raise PrepaidfactoryApi::ConnectionNoValidEndpointSpecified,
                'No valid endpoint specified, please verify your settings'
        else
          raise PrepaidfactoryApi::OperationWrongSetup,
                "Something seems off with your config '#{operation}': #{e.message}"
        end
      rescue OpenSSL::X509::CertificateError => e
        raise PrepaidfactoryApi::ConnectionCertificateError,
              "There is a problem with the certificates: '#{operation}': #{e.message}"
      rescue HTTPI::SSLError
        raise PrepaidfactoryApi::ConnectionSSLError,
              "Unable to setup a verified SSL connection: '#{operation}'"
      rescue => e
        raise PrepaidfactoryApi::OperationUncaught,
              "Uncaught error on operation '#{operation}': #{e.message} #{e}"
      end

      response_to_object operation, response.body
    end

    def response_to_object(operation, response)
      response_class = objectify "PrepaidfactoryApi::Responses::#{camelize operation}"
      response_class.new(response)
    rescue PrepaidfactoryApi::OperationUnableToObjectify
      raise PrepaidfactoryApi::OperationUnknownResponseObject,
            "Unable to initialize a #{response_class} response object"
    end

    def camelize(subject)
      subject.to_s.split('_').map(&:capitalize).join
    end

    def objectify(subject)
      subject.split('::').inject(Object) {|obj, const|
        obj.const_get const
      }
    rescue NameError
      raise PrepaidfactoryApi::OperationUnableToObjectify,
            "Unable to objectify #{subject}"
    end
  end
end
