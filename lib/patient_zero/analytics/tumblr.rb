module PatientZero
  module Analytics
    class Tumblr < Base
      def messages
        []
      end

      def total_posts
        analytical_data.fetch('total_posts').to_i
      end

      def engagements
        likes
      end

      def followers
        analytical_data.fetch('total_followers').to_i
      end

      def likes
        analytical_data.fetch('total_likes').to_i
      end
    end
  end
end
