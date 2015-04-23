module PatientZero
  module Monitoring
    class Twitter
      include Client

      VALID_DAYS = [1,7,30]
      attr_reader :profile_id, :days

      def initialize profile_id:, days: nil
        @profile_id = profile_id
        @days = set_to_valid_days days
      end

      def top_cities
        statistical_data['top_cities']
      end

      private

      def set_to_valid_days days
        VALID_DAYS.fetch(VALID_DAYS.index(days) || VALID_DAYS.index(30))
      end

      def statistical_data
        @statistical_data ||= get '/social/api/monitoring/twitter/stats', api_key: PatientZero.api_key,
                                                                          profile_id: profile_id,
                                                                          days: days
        @statistical_data['stats']
      end
    end
  end
end
