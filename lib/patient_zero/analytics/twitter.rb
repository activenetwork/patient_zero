module PatientZero
  module Analytics
    class Twitter < Base
      def impressions
      end

      def reach
        followers
      end

      def engagements
      end

      def tweets
        analytical_data[:total_tweets]
      end

      def retweets
        analytical_data[:total_retweets]
      end

      def tweets_with_links
        analytical_data[:total_tweets_with_links]
      end

      def followers
        analytical_data[:total_tweets]
      end

      def following
        analytical_data[:total_tweets]
      end

      def lists
        analytical_data[:total_lists]
      end

      def favorites
        analytical_data[:total_favorites]
      end

      def user_mentions
        analytical_data[:total_user_mentions]
      end

      def impressions
        analytical_data[:total_impressions]
      end
    end
  end
end
