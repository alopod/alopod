# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'alopod/version'

Gem::Specification.new do |spec|
  spec.name          = 'alopod'
  spec.version       = Alopod::VERSION
  spec.authors       = ['Ruby Coder']
  spec.email         = ['rubycoder@example.com']
  spec.summary       = 'A lightweight Ruby library for the Ceph Rest API'
  spec.description   = 'Alopod is a Ruby library for the Ceph Rest API'
  spec.homepage      = 'https://github.com/alopod/alopod'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '~> 3.2', '>= 3.2.8'
  spec.add_dependency 'faraday', '~> 0.9', '>= 0.9.1'
  spec.add_dependency 'hashie', '~> 3.2', '>= 3.2.0'

  spec.add_development_dependency 'bundler', '~> 1.9', '>= 1.9.2'
  spec.add_dependency 'pry', '~> 0.10', '>= 0.10.1'
end
