module PatientZero
  module Message
    class Instagram < Base
      def engagements
        @engagements ||= likes + comments + clicks + shares
      end

      def impressions
        data.fetch 'impressions'
      end

      def likes
        data.fetch 'likes'
      end

      def comments
        data.fetch 'comments'
      end

      def clicks
        data.fetch 'clicks'
      end

      def shares
        data.fetch('shares').to_i
      end
    end
  end
end
