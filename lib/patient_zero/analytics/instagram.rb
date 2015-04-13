module PatientZero
  module Analytics
    class Instagram < Base
      def posts
        @posts ||= analytical_data[:total_posts]
      end

      def likes
        @likes ||= analytical_data[:total_likes]
      end

      def comments
        @comments ||= analytical_data[:total_comments]
      end

      def followers
        @followers ||= analytical_data[:total_followers]
      end

      def following
        @following ||= analytical_data[:total_following]
      end
    end
  end
end
