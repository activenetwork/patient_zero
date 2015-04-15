module PatientZero
  module Message
    class Facebook < Base
      def engagements
        @engagements ||= likes + comments + shares + clicks
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

      def shares
        data.fetch 'shares'
      end

      def clicks
        data.fetch 'clicks'
      end
    end
  end
end
