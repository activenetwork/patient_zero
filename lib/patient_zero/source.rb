module PatientZero
  class Source
    include Client

    attr_accessor :id, :name, :platform, :token, :delete_id, :token

    def initialize attributes
      @id = attributes.fetch 'id'
      @name = attributes.fetch 'name'
      @invalid = attributes.fetch 'is_invalid'
      @tracked = attributes.fetch 'is_tracked'
      @platform = attributes.fetch 'platform'
      @delete_id = attributes.fetch 'delete_id'
      @token = attributes.fetch 'token'
    end

    def self.all token=Authorization.token
      response = get '/mobile/api/v1/sources/', client_token: token
      response['sources'].map do |source_attributes|
        new source_attributes.merge('token' => token)
      end
    end

    def self.find source_id, token
      response = get '/mobile/api/v1/sources/show/', id: source_id, client_token: token
      new response['source'].merge('token' => token)
    rescue Error => e
      raise NotFoundError, e
    end

    def platform_id
      id.split('#').last
    end

    def social_type
      id.scan(/\d+#(\w+)#\d+/).flatten.first
    end

    def parent
      if delete_id == id
        self
      else
        Source.find delete_id, token
      end
    end

    def analytics start_date: nil, end_date: nil
      @analytics ||= {}
      @analytics["#{start_date}#{end_date}"] ||= Analytics.for_platform platform, token: token, source_id: id, start_date: start_date, end_date: end_date
    end
  end
end
