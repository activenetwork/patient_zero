module PatientZero
  module Monitoring
    describe Twitter do
      let(:profile_id) { 1 }
      let(:days) { 1 }
      let(:twitter_object) { Twitter.new(profile_id: profile_id, days: days) }
      let(:twitter_response) { { 'top_cities' => { 'San Diego' => 121212 } } }
      let(:twitter_response_with_body) { response_with_body stats: twitter_response }

      describe '#initialize' do
        it 'news up an object' do
          expect(twitter_object).to be_a Twitter
        end

        context 'invalid days' do
          let(:days) { 2 }
          it 'sets default days of 30 for invalid days' do
            expect(twitter_object.days).to eql 30
          end
        end
      end

      describe '#top_cities' do
        before { allow(Twitter.connection).to receive(:get).with('/social/api/monitoring/twitter/stats', anything) { twitter_response_with_body } }
        it 'returns the top cities' do
          expect(twitter_object.top_cities).to eql twitter_response['top_cities']
        end
      end
    end
  end
end
