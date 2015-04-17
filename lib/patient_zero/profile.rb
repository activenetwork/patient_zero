module PatientZero
  class Profile < Client
    attr_accessor :id, :expression, :name, :category

    def initialize attributes
      @id = attributes.fetch 'id'
      @expression = attributes.fetch 'expression'
      @name = attributes.fetch 'name'
      @category = attributes.fetch 'category'
    end

    def self.all
      response = get '/social/api/v2/monitoring/profiles', api_key: PatientZero.api_key
      response['profiles'].map do |profile_attributes|
        new profile_attributes
      end
    end

    def self.find id
      response = get '/social/api/v2/monitoring/profiles', api_key: PatientZero.api_key, id: id
      new response['profiles'].first
    end

    def self.create params={}
      response = post '/social/api/v2/monitoring/profiles', api_key: PatientZero.api_key, profile: params
      new response['profile']
    end
  end
end
