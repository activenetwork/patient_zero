module PatientZero
  class Base
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
      connection.get *args
    end

    def self.post *args
      connection.post *args
    end

    private

    def parse request
      self.class.parse request
    end

    def get *args
      self.class.get *args
    end

    def post *args
      self.class.post *args
    end

    def connection
      self.class.connection
    end
  end
end
