module PatientZero
  class Authorization < Base
    def self.token
      response = parse connection.post '/mobile/api/v1/user/login',
                                       email: PatientZero.email,
                                       password: PatientZero.password
      response['user_token']
    end
  end
end
