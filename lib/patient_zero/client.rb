module PatientZero
  class Client
    def self.connection
      @@connection ||= Faraday.new(PatientZero.url) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end
    end

    def self.parse request
      response = JSON.parse request.body
      raise Error, response['error'] unless response['error'].nil?
      response
    end

    def self.get *args
      parse connection.get *args
    end

    def self.post *args
      parse connection.post *args
    end

    def self.put *args
      parse connection.put *args
    end
    
    private

    def get *args
      self.class.get *args
    end

    def post *args
      self.class.post *args
    end

    def put *args
      self.class.put *args
    end
  end
end
