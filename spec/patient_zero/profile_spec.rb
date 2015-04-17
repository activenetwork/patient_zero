require 'spec_helper'

module PatientZero
  describe Profile do
    let(:id) { 12345 }
    let(:token) { 'token-shmoken' }
    let(:category) { 'blooper' }
    let(:name) { 'blooper' }
    let(:expression) { 'blooper' }
    let(:profiles) { [profile_data] }
    let(:profile_data) do
      {
        "id" => id,
        "expression"=>name,
        "name"=>expression,
        "category"=>category
      }
    end

    before { allow(Authorization).to receive(:token).and_return token }

    describe '.all' do
      let(:profile_response) { response_with_body profiles: profiles }
      before { allow(Client.connection).to receive(:get).with('/social/api/v2/monitoring/profiles', anything) { profile_response } }

      it 'calls the profiles api endpoint' do
        expect(Client.connection).to receive(:get).with('/social/api/v2/monitoring/profiles', anything)
        Profile.all
      end

      it 'returns an Array of Profile objects' do
        expect(Profile.all.first).to be_a Profile
      end
    end

    describe '.find' do
      let(:profile_response) { response_with_body profiles: [profile_data] }
      before { allow(Client.connection).to receive(:get).with('/social/api/v2/monitoring/profiles', anything) { profile_response } }

      it 'calls the profiles api endpoint' do
        expect(Client.connection).to receive(:get).with('/social/api/v2/monitoring/profiles', anything)
        Profile.find id
      end

      it 'returns a Profile object' do
        expect(Profile.find(id)).to be_a Profile
      end
    end

    describe '.create' do
      let(:profile_response) { response_with_body profile: profile_data }
      before { allow(Client.connection).to receive(:post).with('/social/api/v2/monitoring/profiles', anything) { profile_response } }

      it 'calls the profiles api endpoint' do
        expect(Client.connection).to receive(:post).with('/social/api/v2/monitoring/profiles', anything)
        Profile.create profile_data
      end

      it 'returns a Profile object' do
        expect(Profile.create(profile_data)).to be_a Profile
      end
    end
  end
end
