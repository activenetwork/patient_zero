module PatientZero
  module Configurable
    attr_accessor :url, :api_key, :email, :password

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
      self
    end

    def reset
      self.url      = 'https://app.viralheat.com'
      self.api_key  = ENV['VIRAL_HEAT_API_KEY']
      self.email    = ENV['VIRAL_HEAT_EMAIL']
      self.password = ENV['VIRAL_HEAT_PASSWORD']
    end
  end
end
