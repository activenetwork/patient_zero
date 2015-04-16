require 'spec_helper'

module PatientZero
  module Analytics
    describe Twitter do
      let(:source_id) { "12345##{platform}#1234567890" }
      let(:platform) { 'twitter' }
      let(:message) do
        { 'platform' => 'TW',
          'retweets' => 6,
          'impressions' => 13,
          'favorites' => 2,
          'clicks' => 12 }
      end
      let(:messages) { [ message ] }
      let(:token) { 'token-shmoken' }
      let(:analytical_data) { { 'messages' => messages, 'total_impressions' => 13 } }
      let(:twitter_analytics) { Twitter.new token: token, source_id: source_id }
      before{ allow(twitter_analytics).to receive(:analytical_data).and_return analytical_data }

      describe '#impressions' do
        it 'returns the total_impressions value from the analytical_data hash' do
          expect(twitter_analytics.impressions).to eq 13
        end
      end

      describe '#engagements' do
        it 'returns the sum of retweets, favorites, and clicks for all messages' do
          expect(twitter_analytics.engagements).to eq 20
        end
      end
    end
  end
end
