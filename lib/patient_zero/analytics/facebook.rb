module PatientZero
  module Analytics
    class Facebook < Base
      def engagements
        @engagements ||= messages.reduce(0) { |sum, message| sum + message.engagements }
      end

      def impressions
        page_impressions + message_impressions
      end

      def impressions_by_gender
        analytical_data['impressions_by_genders']
      end

      private

      def message_impressions
        messages.reduce(0) { |sum, message| sum + message.impressions }
      end

      def page_impressions
        analytical_data['page_impressions'].find do |impressions_hash|
          impressions_hash['key'] == 'Total'
        end['values'].each_value.reduce(:+)
      end
    end
  end
end
