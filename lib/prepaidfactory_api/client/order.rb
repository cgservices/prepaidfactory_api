module PrepaidfactoryApi

  class Order

    attr_writer :cancelable, :autoConfirm, :reference

    def initialize
      @cancelable = true
      @autoConfirm = false
      @reference = ''
      super
    end

  end
end
