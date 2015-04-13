require 'spec_helper'

module PatientZero
  describe Source do
    let(:token) { 'token-shmoken' }
    let(:sources_response_data) { [source_response_data] }
    let(:source_response_data) do
      {"id"=>"12345#instagram_account#1234567890",
       "name"=>"account_name",
       "is_invalid"=>false,
       "is_tracked"=>true,
       "platform"=>"instagram",
       "delete_id"=>"12345#instagram_account#1234567890"}
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

    describe '#profile_id' do
      it 'retuqrns the number at the end of the id' do
        expect(source.profile_id).to eq '1234567890'
      end
    end
  end
end
