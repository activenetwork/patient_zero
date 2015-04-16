require 'spec_helper'

module PatientZero
  module Message
    describe Instagram do
      let(:data) do
        { 'platform' => 'IG',
          'likes' => 93,
          'comments' => 7,
          'impressions' => 345,
          'shares' => '22',
          'clicks' => 38 }
      end
      subject(:instagram_message) { Instagram.new data }

      describe '#engagements' do
        it 'returns the sum of likes, comments, shares, and clicks' do
          expect(instagram_message.engagements).to eq 160
        end
      end

      describe '#impressions' do
        it 'returns the impression variable from the data hash' do
          expect(instagram_message.impressions).to eq 345
        end
      end

      describe '#likes' do
        it 'returns the likes variable from the data hash' do
          expect(instagram_message.likes).to eq 93
        end
      end

      describe '#comments' do
        it 'returns the comments variable from the data hash' do
          expect(instagram_message.comments).to eq 7
        end
      end

      describe '#shares' do
        it 'returns the shares variable from the data hash' do
          expect(instagram_message.shares).to eq 22
        end
      end

      describe '#clicks' do
        it 'returns the clicks variable from the data hash' do
          expect(instagram_message.clicks).to eq 38
        end
      end
    end
  end
end
