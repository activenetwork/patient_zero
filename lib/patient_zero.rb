require 'json'
require 'faraday'
require 'patient_zero/version'
require 'patient_zero/base'
require 'patient_zero/configurable'
require 'patient_zero/authorization'
require 'patient_zero/organization'
require 'patient_zero/source'
require 'patient_zero/stream'
require 'patient_zero/message'

module PatientZero
  extend PatientZero::Configurable
  class Error < StandardError; end
end

PatientZero.configure do |config|
  config.url = 'https://app.viralheat.com'
end

# Configuration Example
# PatientZero.configure do |config|
#   config.api_key = 'somethingsomethingdangerzone'
#   config.email = 'duchess@cia.gov'
#   config.password = 'password'
# end
