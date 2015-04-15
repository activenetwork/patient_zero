require 'spec_helper'

module PatientZero
  module Analytics
    describe Instagram do
      let(:source_id) { "12345##{platform}#1234567890" }
      let(:platform) { 'instagram' }
      let(:message) do
        { 'platform' => 'IG',
          'impressions' => 10101,
          'shares'=>'3',
          'likes'=>52,
          'comments'=>3,
          'clicks'=>14 }
      end
      let(:messages) { [ message ] }
      let(:token) { 'token-shmoken' }
      let(:analytical_data) { { 'messages' => messages } }
      let(:instagram_analytics) { Instagram.new token: token, source_id: source_id }
      before{ allow(instagram_analytics).to receive(:analytical_data).and_return analytical_data }

      describe '#impressions' do
        it 'returns the sum of impressions for all messages' do
          expect(instagram_analytics.impressions).to eq 10101
        end
      end

      describe '#engagements' do
        it 'returns the sum of retweets, favorites, and clicks for all messages' do
          expect(instagram_analytics.engagements).to eq 72
        end
      end
    end
  end
end
