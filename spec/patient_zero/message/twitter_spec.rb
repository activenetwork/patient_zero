require 'spec_helper'

module PatientZero
  module Message
    describe Twitter do
      let(:data) do
        { 'platform' => 'TW',
          'favorites' => 7,
          'impressions' => 345,
          'retweets' => 22,
          'clicks' => 38 }
      end
      subject(:twitter_message) { Twitter.new data }

      describe '#engagements' do
        it 'returns the sum of retweets, favorites, and clicks' do
          expect(twitter_message.engagements).to eq 67
        end
      end

      describe '#retweets' do
        it 'returns the retweets variable from the data hash' do
          expect(twitter_message.retweets).to eq 22
        end
      end

      describe '#favorites' do
        it 'returns the favorites variable from the data hash' do
          expect(twitter_message.favorites).to eq 7
        end
      end

      describe '#clicks' do
        it 'returns the clicks variable from the data hash' do
          expect(twitter_message.clicks).to eq 38
        end
      end
    end
  end
end
