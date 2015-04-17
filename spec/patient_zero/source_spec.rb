require 'spec_helper'

module PatientZero
  describe Source do
    let(:id) { '12345#instagram_account#1234567890' }
    let(:token) { 'token-shmoken' }
    let(:sources_response_data) { [source_response_data] }
    let(:source_response_data) do
      {'id'=> id,
       'name' => 'account_name',
       'is_invalid' => false,
       'is_tracked' => true,
       'platform' => 'instagram',
       'delete_id' => id }
    end
    let(:source) { Source.new source_response_data, token }

    describe '.all' do
      before do
        allow(Authorization).to receive(:token).and_return token
        allow(Client.connection).to receive(:get).with('/mobile/api/v1/sources/', anything).and_return response_with_body sources: sources_response_data
      end
      it 'calls the sources index api' do
        expect(Client.connection).to receive(:get).with('/mobile/api/v1/sources/', anything)
        Source.all
      end
      it 'calls Authorization.token if no token is passed in' do
        expect(Authorization).to receive(:token)
        Source.all
      end
      context 'when the associated organization token has sources' do
        it 'returns an array of sources' do
          expect(Source.all.first.id).to eq source.id
        end
      end
      context 'when the associated organization token has no sources' do
        it 'returns an empty array' do
          allow(Client.connection).to receive(:get).with('/mobile/api/v1/sources/', anything).and_return response_with_body sources: []
          expect(Source.all).to be_empty
        end
      end
    end

    describe '.find' do
      before do
        allow(Authorization).to receive(:token).and_return token
        allow(Client.connection).to receive(:get).with('/mobile/api/v1/sources/show/', anything).and_return response_with_body source: source_response_data
      end
      it 'calls the sources show api' do
        expect(Client.connection).to receive(:get).with('/mobile/api/v1/sources/show/', anything)
        Source.find id, token
      end
      context 'when the source exists' do
        it 'returns a source' do
          expect(Source.find(id, token).id).to eq source.id
        end
      end
      context 'when no source exists' do
        it 'throws an PatientZero::Error' do
          allow(Client).to receive(:get).and_raise Error, 'The source could not be found. Please check your inputs.'
          expect{ Source.find id, token }.to raise_error PatientZero::NotFoundError
        end
      end
    end

    describe '#profile_id' do
      it 'returns the number at the end of the id' do
        expect(source.profile_id).to eq '1234567890'
      end
    end

    describe '#analytics' do
      it 'calls Analytics.for_platorm to create an analytics object' do
        expect(Analytics).to receive(:for_platform).with(source.platform, { token: source.token, source_id: source.id, start_date: nil, end_date: nil })
        source.analytics
      end
    end
  end
end
