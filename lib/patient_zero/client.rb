module PatientZero
  module Client
    def self.included base
      base.extend self
    end

    def connection
      PatientZero.connection ||= Faraday.new(PatientZero.url) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end
    end

    def parse request
      response = JSON.parse request.body
      raise Error, response['error'] unless response['error'].nil?
      response
    end

    def get *args
      parse connection.get *args
    end

    def post *args
      parse connection.post *args
    end

    def put *args
      parse connection.put *args
    end
  end
end
