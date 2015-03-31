require 'spec_helper'

module PatientZero
  describe Authorization do
    describe '.token' do
      let(:token) { 'token-shmoken' }
      let(:body) { "{\"status\":200,\"error\":null,\"user_token\":\"#{token}\"}" }
      before{ allow(Base.connection).to receive(:post).and_return double(body: body) }
      it 'calls the login api endpoint' do
        expect(Base.connection).to receive(:post).with('/mobile/api/v1/user/login', anything)
        Authorization.token
      end
      it 'returns a user_token' do
        expect(Authorization.token).to eq token
      end
    end
  end
end
