module PatientZero
  class Organization < Base
    attr_accessor :id, :name, :avatar

    def initialize attributes
      @id = attributes.fetch 'id'
      @name = attributes.fetch 'name'
      @avatar = attributes.fetch 'avatar'
    end

    def self.all
      response = parse get '/mobile/api/v1/organizations', client_token: Authorization.token
      response['organizations'].map do |organization_attributes|
        new organization_attributes
      end
    end

    def sources
      Source.all token
    end

    def token
      response = parse get "/mobile/api/v1/organizations/#{id}/switch", client_token: Authorization.token
      response['user_token']
    end
  end
end
