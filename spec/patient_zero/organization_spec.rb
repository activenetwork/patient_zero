require 'spec_helper'

module PatientZero
  describe Organization do
    let(:id) { 12345 }
    let(:token) { 'token-shmoken' }
    let(:organization) { Organization.new organization_response_data }
    let(:organizations_response_data) { [organization_response_data] }
    let(:organization_response_data) do
      { "id"=>id,
        "name"=>"Organization One",
        "avatar"=>
          { "thumbnail"=>"https://s3.amazonaws.com/viralheat/avatars/organizations/12345/thumb/fake_img_1.png",
            "medium"=>"https://s3.amazonaws.com/viralheat/avatars/organizations/12345/medium/fake_img_1.png",
            "large"=>"https://s3.amazonaws.com/viralheat/avatars/organizations/12345/large/fake_img_1.png" } }
    end

    before { allow(Authorization).to receive(:token).and_return token }

    describe '.all' do
      let(:organizations) { [organization] }
      let(:organizations_response) { response_with_body organizations: organizations_response_data }
      before { allow(Base.connection).to receive(:get).with('/mobile/api/v1/organizations', anything) { organizations_response } }

      it 'calls the organizations api endpoint' do
        expect(Base.connection).to receive(:get).with('/mobile/api/v1/organizations', anything)
        Organization.all
      end

      context 'if the user has organizations' do
        it 'returns an array of all organizations available' do
          expect(Organization.all.map(&:id)).to eq organizations.map(&:id)
        end
      end

      context 'if the user has no organizations' do
        let(:organizations_response_data) { [] }
        it 'returns an empty array' do
          expect(Organization.all).to be_empty
        end
      end
    end

    describe '#sources' do
      it 'calls Source.all and passes its own organization user_token' do
        allow(organization).to receive(:token).and_return token
        expect(Source).to receive(:all).with(token)
        organization.sources
      end
    end

    describe '#token' do
      let(:organization_specific_token) { 'organization-token' }
      let(:switch_response) { response_with_body user_token: organization_specific_token }
      before { allow(Base.connection).to receive(:get).with("/mobile/api/v1/organizations/#{id}/switch", anything).and_return switch_response }

      it 'calls the organization switch api endpoint' do
        expect(Base.connection).to receive(:get).with("/mobile/api/v1/organizations/#{id}/switch", anything)
        organization.token
      end

      it 'returns the organization specific user_token' do
        expect(organization.token).to eq organization_specific_token
      end
    end
  end
end
