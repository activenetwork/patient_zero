module PatientZero
  class Stream < Base
    attr_accessor :source_id, :token

    def initialize(source_id:, token:)
      @source_id = source_id
      @token = token
    end

    def messages
      get_data
      @stream_data.map do |stream_datum|
        Message.new stream_datum
      end
    end

    def get_data
      response = parse get "/mobile/api/v1/stream",
        social_object_uid: source_id,
        client_token: token
      @next_page = response['next_page']
      @stream_data = response['stream']
    end

    def next_page
      if @next_page
        response = parse get @next_page
        @next_page = response['next_page']
        @stream_data += response['stream']
      else
        get_data
      end
    end
  end
end
