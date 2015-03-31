module PatientZero
  class Source < Base
    attr_accessor :id, :name, :platform, :token
    def self.all token=Authorization.token
      response = parse connection.get '/mobile/api/v1/sources/',
        client_token: token
      response['sources'].map do |source_attributes|
        new source_attributes, token
      end
    end

    def initialize attributes, token
      @id = attributes.fetch 'id'
      @name = attributes.fetch 'name'
      @invalid = attributes.fetch 'is_invalid'
      @tracked = attributes.fetch 'is_tracked'
      @platform = attributes.fetch 'platform'
      @token = token
    end

    def profile_id
      id.split('#').last
    end

    def stream
      Stream.new source_id: id, token: token
    end

    def mentions
      response = parse connection.get "/social/api/v2/monitoring/#{platform}/mentions",
                                      api_key: PatientZero.api_key,
                                      profile_id: profile_id
      response['mentions']
    end
  end
end
