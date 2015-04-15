module PatientZero
  module Message
    class Twitter < Base
      def engagements
        @engagements ||= retweets + favorites + clicks
      end

      def retweets
        data.fetch 'retweets'
      end

      def favorites
        data.fetch 'favorites'
      end

      def clicks
        data.fetch 'clicks'
      end
    end
  end
end
