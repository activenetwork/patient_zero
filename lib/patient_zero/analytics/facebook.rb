module PatientZero
  module Analytics
    class Facebook < Base
      def engagements
        @engagements ||= messages.reduce(0) { |sum, message| sum + message.engagements }
      end

      def impressions
        @impressions ||= page_impressions + message_impressions
      end

      def reach
        @reach ||= analytical_data['total_reach'].find do |reach_hash|
          reach_hash['key'] == 'Total Reach'
        end['values'].each_value.reduce(:+)
      end

      def impressions_by_city
        analytical_data.fetch("impressions_by_cities").each_with_object({}) do |city, cities|
          cities[city['title']] = city['count']
        end
      end

      def impressions_by_age
        analytical_data.fetch('impressions_by_ages',[]).first.to_h.fetch('values',{})
      end

      def impressions_by_gender
        gender_stats = analytical_data['impressions_by_genders']
        { female:  gender_stats.fetch('F', 0),
          male:    gender_stats.fetch('M', 0),
          unknown: gender_stats.fetch('U', 0) }
      end

      def page_likes_by_age_and_gender
        data = analytical_data.fetch('likes_by_age_group',[])
        female = data.find { |datum| datum.values.include? 'Females Users' }
        male   = data.find { |datum| datum.values.include? 'Males Users' }
        { female: female.to_h.fetch('values',{}),
          male: male.to_h.fetch('values',{}) }
      end

      def page_likes_by_gender
        gender_stats = analytical_data['likes_by_gender']
        { female:  gender_stats.fetch('F', 0),
          male:    gender_stats.fetch('M', 0),
          unknown: gender_stats.fetch('U', 0) }
      end

      def total_page_likes
        page_likes_by_gender.values.reduce(:+)
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
