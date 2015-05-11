module PatientZero
  class Error < StandardError; end
  class NotFoundError < Error; end
  class InvalidPlatformError < Error; end
end
