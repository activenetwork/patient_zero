require 'spec_helper'

module PatientZero
  describe Authorization do
    describe '.token' do
      let(:token) { 'token-shmoken' }
      let(:authorization_response) { response_with_body user_token: token }
      before{ allow(Authorization.connection).to receive(:post).with('/mobile/api/v1/user/login', anything).and_return authorization_response }
      it 'calls the login api endpoint' do
        expect(Authorization.connection).to receive(:post).with('/mobile/api/v1/user/login', anything)
        Authorization.token
      end
      context 'when email and password are correct' do
        it 'returns a user_token' do
          expect(Authorization.token).to eq token
        end
      end
      context 'when email and password are incorrect' do
        let(:authorization_response) { response_with_body error: 'Invalid login/password' }
        it 'raises a PatientZero::Error error' do
          expect{ Authorization.token }.to raise_error PatientZero::Error
        end
      end
    end
  end
end
