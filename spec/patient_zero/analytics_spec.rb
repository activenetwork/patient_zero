require 'spec_helper'

module PatientZero
  describe Analytics do
    describe '.for_platform' do
      let(:data_hash) { { token: "", source_id: "" } }
      context 'when platform is Facebook' do
        let(:platform) { 'facebook' }
        it 'news up a Analytics::Facebook object' do
          expect(Analytics.for_platform(platform, data_hash)).to be_a Analytics::Facebook
        end
      end

      context 'when platform is Twitter' do
        let(:platform) { 'twitter' }
        it 'news up a Analytics::Twitter object' do
          expect(Analytics.for_platform(platform, data_hash)).to be_a Analytics::Twitter
        end
      end

      context 'when platform is Instagram' do
        let(:platform) { 'instagram' }
        it 'news up a Analytics::Instagram object' do
          expect(Analytics.for_platform(platform, data_hash)).to be_a Analytics::Instagram
        end
      end
    end
  end
end
