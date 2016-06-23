module PrepaidfactoryApi

  class Exception < StandardError
    attr_reader :object

    def initialize(object)
      @object = object
      super
    end
  end
end
