require 'spec_helper'

module PatientZero
  module Analytics
    describe Tumblr do
      let(:source_id) { "12345##{platform}#1234567890" }
      let(:platform) { 'tumblr' }
      let(:token) { 'token-shmoken' }
      let(:followers) { '26' }
      let(:likes) { '89' }
      let(:posts) { '45' }
      let(:analytical_data) { { 'total_posts'=>posts, 'total_followers'=>followers, 'total_likes'=>likes } }
      let(:tumblr_analytics) { Tumblr.new token: token, source_id: source_id }
      before{ allow(tumblr_analytics).to receive(:analytical_data).and_return analytical_data }

      describe '#messages' do
        it 'returns an empty array' do
          expect(tumblr_analytics.messages).to eq []
        end
      end

      describe '#total_posts' do
        it 'returns the number of posts from the analytical_data hash' do
          expect(tumblr_analytics.total_posts).to eq posts.to_i
        end
      end

      describe '#engagements' do
        it 'returns the sum of likes from the analytical_data hash' do
          expect(tumblr_analytics.engagements).to eq likes.to_i
        end
      end

      describe '#followers' do
        it 'returns the number of followers from the analytical_data hash' do
          expect(tumblr_analytics.followers).to eq followers.to_i
        end
      end

      describe '#likes' do
        it 'returns the number of likes from the analytical_data hash' do
          expect(tumblr_analytics.likes).to eq likes.to_i
        end
      end
    end
  end
end
