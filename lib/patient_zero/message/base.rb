module PatientZero
  module Message
    class Base
      def initialize data
        @data = data
      end

      def method_missing name, *args
        if @data.has_key? name.to_s
          @data.fetch name.to_s
        else
          super
        end
      end
    end
  end
end
