module PatientZero
  module Monitoring
    class Twitter
      VALID_DAYS = [1,7,30]
      attr_reader :profile_id, :days

      def initialize profile_id:, days: nil
        @profile_id = profile_id
        @days = VALID_DAYS.fetch(VALID_DAYS.index(days) || VALID_DAYS.index(30))
      end

      def top_cities
        statistical_data['top_cities']
      end

      private

      def statistical_data
        fields = ['gender', 'top_countries', 'top_cities', 'top_influencers_by_impact', 'top_influencers_by_volume', 'top_mentions']
        @statistical_data ||= get '/social/api/v2/monitoring/twitter/stats', api_key: PatientZero.api_key,
                                                                             profile_id: profile_id,
                                                                             days: days,
                                                                             fields: fields
        @statistical_data['stats']
      end
    end
  end
end
