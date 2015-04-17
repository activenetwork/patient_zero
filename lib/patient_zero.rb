require 'json'
require 'faraday'
require 'patient_zero/version'
require 'patient_zero/errors'
require 'patient_zero/client'
require 'patient_zero/configurable'
require 'patient_zero/authorization'
require 'patient_zero/organization'
require 'patient_zero/analytics'
require 'patient_zero/source'
require 'patient_zero/message'
require 'patient_zero/profile'

module PatientZero
  extend PatientZero::Configurable
end

# Configuration Example
# PatientZero.configure do |config|
#   config.api_key = 'somethingsomethingdangerzone'
#   config.email = 'duchess@cia.gov'
#   config.password = 'password'
# end
