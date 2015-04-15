module PatientZero
  module Analytics
    class Instagram < Base
      def engagements
        @engagements ||= messages.reduce(0) { |sum, message| sum + message.engagements }
      end

      def impressions
        @impressions ||= messages.reduce(0) { |sum, message| sum + message.impressions }
      end
    end
  end
end
