# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'patient_zero/version'

Gem::Specification.new do |spec|
  spec.name          = 'patient_zero'
  spec.version       = PatientZero::VERSION
  spec.authors       = ['Adam Zaninovich','Devin Clark']
  spec.email         = ['adam.zaninovich@gmail.com', 'notdevinclark@gmail.com']
  spec.summary       = %q{A gem to use the Viral Heat API}
  spec.description   = %q{A gem to use the Viral Heat API}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'

  spec.add_dependency             'faraday'
  spec.add_dependency             'json'
end
