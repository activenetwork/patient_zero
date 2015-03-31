require 'spec_helper'

module PatientZero
  describe Base do
    let(:token) { 'token-shmoken' }
    let(:body) { "{}" }
    let(:response) { double body: body }

    describe '.connection' do
      it 'news up a connection to the Viral Heat API' do
        expect(Faraday).to receive(:new)
        Base.connection
      end
    end

    describe '.parse' do
      subject(:parse) { Base.parse response }
      context 'when the response contains an error key with nil' do
        let(:body) { "{\"status\":200,\"error\":null,\"user_token\":\"#{token}\"}" }
        it 'returns a hash of data' do
          expect(parse).to be_a Hash
        end
      end
      context 'when the response contains an error key that is not nil' do
        let(:body) { "{\"status\":403,\"error\":\"Invalid login/password\",\"user_token\":null}" }
        it 'raises an error' do
          expect { parse }.to raise_error Error
        end
      end
    end
  end
end
