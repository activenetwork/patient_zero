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

    private

    def parse request
      self.class.parse request
    end

    def connection
      self.class.connection
    end
  end
end
