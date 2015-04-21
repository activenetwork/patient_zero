require 'spec_helper'

module PatientZero
  class FakeClient
    include Client
  end

  describe Client do
    let(:token) { 'token-shmoken' }
    let(:body) { "{}" }
    let(:response) { double :response, body: body }
    let(:connection) { double :conn, get: response, post: response, put: response }

    describe '.connection' do
      it 'news up a connection to the Viral Heat API' do
        expect(FakeClient.connection).to be_a Faraday::Connection
      end

      it 'exists on the instance' do
        expect { FakeClient.new.connection }.to_not raise_error
      end
    end

    describe '.parse' do
      it 'exists on the instance' do
        expect { FakeClient.new.parse response }.to_not raise_error
      end
      context 'when the response contains an error key with nil' do
        let(:body) { "{\"status\":200,\"error\":null,\"user_token\":\"#{token}\"}" }
        it 'returns a hash of data' do
          expect(FakeClient.parse response).to be_a Hash
        end
      end
      context 'when the response contains an error key that is not nil' do
        let(:body) { "{\"status\":403,\"error\":\"Invalid login/password\",\"user_token\":null}" }
        it 'raises an error' do
          expect { FakeClient.parse response }.to raise_error Error
        end
      end
    end

    describe '.get' do
      before { allow(PatientZero).to receive(:connection).and_return connection }

      it 'delegates to the connection' do
        expect(PatientZero.connection).to receive(:get).with('an arg') { response }
        FakeClient.get 'an arg'
      end

      it 'calls parse' do
        expect(FakeClient).to receive(:parse).with response
        FakeClient.get 'an arg'
      end

      it 'exists on the instance' do
        expect { FakeClient.new.get 'an arg' }.to_not raise_error
      end
    end

    describe '.post' do
      before { allow(PatientZero).to receive(:connection).and_return connection }

      it 'delegates to the connection' do
        expect(PatientZero.connection).to receive(:post).with('an arg') { response }
        FakeClient.post 'an arg'
      end

      it 'calls parse' do
        expect(FakeClient).to receive(:parse).with response
        FakeClient.post 'an arg'
      end

      it 'exists on the instance' do
        expect { FakeClient.new.post 'an arg' }.to_not raise_error
      end
    end

    describe '.put' do
      before { allow(PatientZero).to receive(:connection).and_return connection }

      it 'delegates to the connection' do
        expect(PatientZero.connection).to receive(:put).with('an arg') { response }
        FakeClient.put 'an arg'
      end

      it 'calls parse' do
        expect(FakeClient).to receive(:parse).with response
        FakeClient.put 'an arg'
      end

      it 'exists on the instance' do
        expect { FakeClient.new.put 'an arg' }.to_not raise_error
      end
    end

  end
end
