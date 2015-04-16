require 'patient_zero/message/base'
require 'patient_zero/message/facebook'
require 'patient_zero/message/twitter'
require 'patient_zero/message/instagram'

module PatientZero
  module Message
    SOURCE_TYPES = {'TW' => Twitter,
                    'FB' => Facebook,
                    'IG' => Instagram}

    def self.for_platform platform, params={}
      SOURCE_TYPES[platform].new params
    end
  end
end
