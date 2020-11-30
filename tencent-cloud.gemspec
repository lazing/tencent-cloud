# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'tencent/cloud/version'

Gem::Specification.new do |s|
  s.name          = 'tencent-cloud'
  s.version       = Tencent::Cloud::VERSION
  s.authors       = ['Ryan Wong']
  s.email         = ['lazing@gmail.com']
  s.homepage      = 'https://github.com/lazing/tencent-cloud'
  s.licenses      = ['MIT']
  s.summary       = '[summary]'
  s.description   = '[description]'

  s.files         = Dir.glob('{bin/*,lib/**/*,[A-Z]*}')
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']

  s.add_dependency 'faraday', '~> 1.0'
  s.add_dependency 'multi_json', '~> 1.0'

  s.add_development_dependency "bundler", "~> 1.17"
  s.add_development_dependency "guard", "~> 2.0"
  s.add_development_dependency "guard-rspec", "~> 4.0"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "rspec-its", "~> 1.0"
  s.add_development_dependency 'webmock', "~> 3.0"
end
