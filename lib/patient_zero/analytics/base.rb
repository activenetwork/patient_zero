module PatientZero
  module Analytics
    class Base < PatientZero::Base
      attr_accessor :token, :source_id, :start_date, :end_date

      def initialize token:, source_id:, start_date: '2015-03-01', end_date: '2015-04-01'
        @token = token
        @source_id = source_id
        @start_date = start_date
        @end_date = end_date
      end

      def name
        @name ||= analytical_data['name']
      end

      def platform
        @platform ||= analytical_data['platform']
      end

      def messages
        @messages ||= analytical_data['messages'].map{|message| Message.new message}
      end

      private

      def analytical_data
        @analytical_data ||= parse(get '/mobile/api/v1/analytics', client_token: token,
                                                       social_object_uid: source_id,
                                                       start_date: start_date,
                                                       end_date: end_date)['stats'].first
      end
    end
  end
end
