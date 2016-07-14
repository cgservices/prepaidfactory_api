module PrepaidfactoryApi
  Error                     = Class.new(RuntimeError)
  # WrongRequestObject        = Class.new(TypeError)

  AuthenticationError       = Class.new(Error)
  CancelOrderNotCancelable  = Class.new(Error)
  CancelOrderNotFound       = Class.new(Error)
  CancelOrderNotOpen        = Class.new(Error)
  CertificateError          = Class.new(Error)
  ConfirmNotAllowed         = Class.new(Error)
  EndpointUnavailable       = Class.new(Error)
  GenericException          = Class.new(Error)
  HTTPError                 = Class.new(Error)
  InvalidRequestType        = Class.new(Error)
  MalformedRequest          = Class.new(Error)
  MalformedRequestObject    = Class.new(Error)
  NoCredit                  = Class.new(Error)
  NoCertificate             = Class.new(Error)
  NoCertificateKey          = Class.new(Error)
  NotImplemented            = Class.new(Error)
  NoValidEndpointSpecified  = Class.new(Error)
  OrderNotFound             = Class.new(Error)
  OutOfStock                = Class.new(Error)
  ProductNotFound           = Class.new(Error)
  RetailerNotFound          = Class.new(Error)
  SOAPFault                 = Class.new(Error)
  SSLError                  = Class.new(Error)
  TerminalLimitExceeded     = Class.new(Error)
  Uncaught                  = Class.new(Error)
  UnknownOperation          = Class.new(Error)
  UnknownStatus             = Class.new(Error)
  WrongSetup                = Class.new(Error)
end
