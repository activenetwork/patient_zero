module PatientZero
  class Source < Base
    attr_accessor :id, :name, :platform, :token

    def initialize attributes, token
      @id = attributes.fetch 'id'
      @name = attributes.fetch 'name'
      @invalid = attributes.fetch 'is_invalid'
      @tracked = attributes.fetch 'is_tracked'
      @platform = attributes.fetch 'platform'
      @token = token
    end

    def self.all token=Authorization.token
      response = parse get '/mobile/api/v1/sources/',
        client_token: token
      response['sources'].map do |source_attributes|
        new source_attributes, token
      end
    end

    def profile_id
      id.split('#').last
    end

    def analytics
      @analytics ||= Analytics.for_platform platform, token: token, source_id: id
    end
  end
end
