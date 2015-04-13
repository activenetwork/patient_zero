module PatientZero
  class Authorization < Client
    def self.token
      response = post '/mobile/api/v1/user/login', email: PatientZero.email, password: PatientZero.password
      response['user_token']
    end
  end
end
