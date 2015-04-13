module PatientZero
  module Message
    class Facebook < Base
      def engagements
        @engagements ||= likes + comments + shares + clicks
      end

      def reach

      end
    end
  end
end
