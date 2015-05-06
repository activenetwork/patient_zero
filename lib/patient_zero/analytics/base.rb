module PatientZero
  module Analytics
    class Base
      include Client

      attr_accessor :token, :source_id, :start_date, :end_date

      def initialize token:, source_id:, start_date: nil, end_date: nil
        @token = token
        @source_id = source_id
        @end_date = end_date || Date.today.to_s
        @start_date = start_date || Date.today.prev_day(7).to_s
      end

      def name
        analytical_data['name']
      end

      def platform
        analytical_data['platform']
      end

      def messages
        analytical_data['messages'].map { |message| Message.for_platform message['platform'], message }
      end

      def total_posts
        messages.count
      end

      private

      def analytical_data
        @analytical_data ||= get('/mobile/api/v1/analytics', client_token: token,
                                                             social_object_uid: source_id,
                                                             start_date: start_date,
                                                             end_date: end_date)['stats'].first
      end
    end
  end
end
