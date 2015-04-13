module PatientZero
  module Analytics
    class Instagram < Base
      def posts
        analytical_data[:total_posts]
      end

      def likes
        analytical_data[:total_likes]
      end

      def comments
        analytical_data[:total_comments]
      end

      def followers
        analytical_data[:total_followers]
      end

      def following
        analytical_data[:total_following]
      end
    end
  end
end
