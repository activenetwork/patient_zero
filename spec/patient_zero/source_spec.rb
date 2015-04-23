require 'spec_helper'

module PatientZero
  describe Source do
    let(:id) { "12345##{social_type}#1234567890" }
    let(:delete_id) { id }
    let(:social_type) { 'facebook_account' }
    let(:token) { 'token-shmoken' }
    let(:sources_response_data) { [source_response_data] }
    let(:source_response_data) do
      {'id'=> id,
       'name' => 'account_name',
       'is_invalid' => false,
       'is_tracked' => true,
       'platform' => 'facebook',
       'delete_id' => delete_id }
    end
    let(:source) { Source.new source_response_data, token }

    describe '.all' do
      before do
        allow(Authorization).to receive(:token).and_return token
        allow(Source.connection).to receive(:get).with('/mobile/api/v1/sources/', anything).and_return response_with_body sources: sources_response_data
      end
      it 'calls the sources index api' do
        expect(Source.connection).to receive(:get).with('/mobile/api/v1/sources/', anything)
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
          allow(Source.connection).to receive(:get).with('/mobile/api/v1/sources/', anything).and_return response_with_body sources: []
          expect(Source.all).to be_empty
        end
      end
    end

    describe '.find' do
      before do
        allow(Authorization).to receive(:token).and_return token
        allow(Source.connection).to receive(:get).with('/mobile/api/v1/sources/show/', anything).and_return response_with_body source: source_response_data
      end
      it 'calls the sources show api' do
        expect(Source.connection).to receive(:get).with('/mobile/api/v1/sources/show/', anything)
        Source.find id, token
      end
      context 'when the source exists' do
        it 'returns a source' do
          expect(Source.find(id, token).id).to eq source.id
        end
      end
      context 'when no source exists' do
        it 'throws an PatientZero::Error' do
          allow(Source).to receive(:get).and_raise Error, 'The source could not be found. Please check your inputs.'
          expect{ Source.find id, token }.to raise_error PatientZero::NotFoundError
        end
      end
    end

    describe '#platform_id' do
      it 'returns the number at the end of the id' do
        expect(source.platform_id).to eq '1234567890'
      end
    end

    describe '#social_type' do
      it 'returns the source type' do
        expect(source.social_type).to eq social_type
      end
    end

    describe '#parent' do
      context 'when the delete_id is the same as the id' do
        it 'returns self' do
          expect(source.parent).to eq source
        end
      end
      context 'when the delete_id is not the same as the id' do
        let(:delete_id) { '12345#facebook_page#1234567890' }
        before { allow(Source).to receive(:find).and_return double :parent_source, id: delete_id }
        it 'calls Source.find' do
          expect(Source).to receive(:find)
          source.parent
        end
        it 'returns a source that is not the same as itself' do
          expect(source.parent.id).to_not eq source.id
        end
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
