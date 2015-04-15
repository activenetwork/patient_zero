module PatientZero
  module Analytics
    class Twitter < Base
      def impressions
        analytical_data['total_impressions']
      end

      def engagements
        @engagements ||= messages.reduce(0) { |sum, message| sum + message.engagements }
      end
    end
  end
end
