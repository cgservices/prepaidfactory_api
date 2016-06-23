module PrepaidfactoryApi

  module Request
    class Base

      def to_hash( )
        instance_variables.each_with_object({}) { |var, hash|
          hash[var.to_s.delete("@")] = gift.instance_variable_get(var)
        }
      end
    end
  end
end
