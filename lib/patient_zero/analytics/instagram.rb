module PatientZero
  module Analytics
    class Instagram < Base
      def engagements
        @engagements ||= messages.reduce(0) { |sum, message| sum + message.engagements }
      end

      def impressions
        @impressions ||= messages.reduce(0) { |sum, message| sum + message.impressions }
      end

      def followers
        analytical_data['total_followers'].to_i
      end

      def reach
        nil
      end

      def impressions_by_city
        {}
      end

      def likes
        analytical_data['total_likes'].to_i
      end

      def total_comments
        analytical_data['total_comments'].to_i
      end
    end
  end
end
