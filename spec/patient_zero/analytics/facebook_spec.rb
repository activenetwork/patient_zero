require 'spec_helper'

module PatientZero
  module Analytics
    describe Facebook do
      let(:source_id) { "12345##{platform}#1234567890" }
      let(:token) { 'token-shmoken' }
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
        [ { 'key'=>'Total', 'values'=> { '2010-10-10'=> 99 }},
           { 'key'=>'Organic', 'values'=> { '2010-10-10'=> 100 }},
           { 'key'=>'Paid', 'values'=> { '2010-10-10'=> 101 }}]
      end
      let(:impressions_by_city) { [{"title"=>"Atlanta, GA", "count"=>16_000}, {"title"=>"Los Angeles, CA", "count"=>15_000}, {"title"=>"San Diego, CA", "count"=>14_000}] }
      let(:impressions_by_age) { [{"key"=>"Users", "values"=>age_data}] }
      let(:impressions_by_gender) { {"F"=>100_000, "M"=>70_000, "U"=>10_000} }
      let(:age_data) { {"13-17"=>14_000, "18-24"=>240_000, "25-34"=>650_000, "35-44"=>660_000, "45-54"=>380_000, "55-64"=>170_000, "65+"=>93_000} }
      let(:total_reach) { [ { 'key'=>'Total Reach', 'values'=> { '2010-10-10'=> 4567 } } ] }
      let(:analytical_data) do
        { 'messages' => messages,
          'page_impressions' => page_impressions,
          'impressions_by_cities' => impressions_by_city,
          'impressions_by_ages' => impressions_by_age,
          'impressions_by_genders' => impressions_by_gender,
          'total_reach' => total_reach }
      end
      let(:facebook_analytics) { Facebook.new token: token, source_id: source_id }
      before{ allow(facebook_analytics).to receive(:analytical_data).and_return analytical_data }

      describe '#impressions_by_city' do
        it 'returns the impressions by city' do
          expected_result = {
            "Atlanta, GA"=>16_000,
            "Los Angeles, CA"=>15_000,
            "San Diego, CA"=>14_000 }
          expect(facebook_analytics.impressions_by_city).to eq expected_result
        end
      end

      describe '#impressions_by_age' do
        it 'returns the impressions by age' do
          expect(facebook_analytics.impressions_by_age).to eq age_data
        end
      end

      describe '#impressions_by_gender' do
        it 'returns the impressions_by_gender' do
          expected_result = {
            female:  impressions_by_gender['F'],
            male:    impressions_by_gender['M'],
            unknown: impressions_by_gender['U']
          }
          expect(facebook_analytics.impressions_by_gender).to eq expected_result
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

      describe '#reach' do
        it 'returns the sum of total_reach for each day' do
          expect(facebook_analytics.reach).to eq 4567
        end
      end

      describe '#organic_impressions' do
        it 'returns the sum of organic_posts' do
          expect(facebook_analytics.organic_impressions).to eq 100
        end
      end

      describe '#promoted_impressions' do
        it 'returns the sum of promoted_posts' do
          expect(facebook_analytics.promoted_impressions).to eq 101
        end
      end
    end
  end
end
