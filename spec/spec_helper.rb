require 'bundler/setup'
Bundler.setup

require 'patient_zero'

module Helpers
  def response_with_body body
    double :response, body: body.to_json
  end
end

RSpec.configure do |config|
  config.include Helpers
end
