require 'spec_helper'

module PatientZero
  module Analytics
    describe Facebook do
      let(:source_id) { "12345##{platform}#1234567890" }
      let(:platform) { 'facebook' }
      let(:message) do
        { 'platform' => 'FB',
          'likes' => 93,
          'comments' => 7,
          'impressions' => 345,
          'shares' => 22,
          'clicks' => 38 }
      end
      let(:messages) { [ message ] }
      let(:page_impressions) do
        [ { 'key'=>'Total',
            'values'=>
            { '2010-10-10'=> 99 } } ]
      end
      let(:impressions_by_gender) { {} }
      let(:token) { 'token-shmoken' }
      let(:analytical_data) { { 'messages' => messages, 'page_impressions' => page_impressions, 'impressions_by_genders' => impressions_by_gender } }
      let(:facebook_analytics) { Facebook.new token: token, source_id: source_id }
      before{ allow(facebook_analytics).to receive(:analytical_data).and_return analytical_data }

      describe '#impressions_by_gender' do
        it 'returns the impressions_by_gender' do
          expect(facebook_analytics.impressions_by_gender).to eq impressions_by_gender
        end
      end

      describe '#impressions' do
        it 'returns the total for message and page impressions' do
          expect(facebook_analytics.impressions).to eq 444
        end
      end

      describe '#engagements' do
        it 'returns the sum of likes, comments, shares, and clicks' do
          expect(facebook_analytics.engagements).to eq 160
        end
      end
    end
  end
end
