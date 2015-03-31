module PatientZero
  module Configurable
    attr_accessor :url, :api_key, :email, :password

    def configure
      yield self
      self
    end
  end
end
