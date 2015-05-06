require 'spec_helper'

module PatientZero
  module Analytics
    describe Base do
      let(:source_id) { "12345##{platform}#1234567890" }
      let(:name) { 'account_name' }
      let(:platform) { 'account_type' }
      let(:messages) { [ { 'platform' => 'FB' } ] }
      let(:token) { 'token-shmoken' }
      let(:analytical_data) { { 'stats' => [ { 'id' => source_id, 'platform' => platform, 'name' => name, 'messages' => messages } ] } }
      subject(:analytics_base) { Base.new token: token, source_id: source_id }
      before { allow(analytics_base).to receive(:get).with('/mobile/api/v1/analytics', anything).and_return analytical_data }

      describe '#name' do
        it 'calls the analytics API endpoint' do
          expect(analytics_base).to receive(:get).with('/mobile/api/v1/analytics', anything)
          analytics_base.name
        end
        it 'pulls the name from the analytical_data hash' do
          expect(analytics_base.name).to be name
        end
      end

      describe '#platform' do
        it 'calls the analytics API endpoint' do
          expect(analytics_base).to receive(:get).with('/mobile/api/v1/analytics', anything)
          analytics_base.name
        end
        it 'pulls the platform from the analytical_data hash' do
          expect(analytics_base.platform).to be platform
        end
      end

      describe '#messages' do
        it 'calls the analytics API endpoint' do
          expect(analytics_base).to receive(:get).with('/mobile/api/v1/analytics', anything)
          analytics_base.name
        end
        context 'when there are messages' do
          it 'returns an array of messages' do
            expect(analytics_base.messages.first).to be_a Message::Facebook
          end
        end
        context 'when there are no messages' do
          let(:messages) { [] }
          it 'returns an empty array' do
            expect(analytics_base.messages).to be_empty
          end
        end
      end

      describe '#total_posts' do
        it 'returns the count of messages' do
          expect(analytics_base.total_posts).to be 1
        end
      end
    end
  end
end
