require 'patient_zero/analytics/base'
require 'patient_zero/analytics/twitter'
require 'patient_zero/analytics/facebook'
require 'patient_zero/analytics/instagram'
require 'patient_zero/analytics/tumblr'

module PatientZero
  module Analytics
    SOURCE_TYPES = {'twitter' => Twitter,
                    'facebook' => Facebook,
                    'instagram' => Instagram,
                    'tumblr' => Tumblr}

    def self.for_platform platform, params={}
      SOURCE_TYPES[platform].new params
    rescue NoMethodError
      nil
    end
  end
end
