# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'tencent/cloud/version'

Gem::Specification.new do |s|
  s.name          = 'tencent-cloud'
  s.version       = Tencent::Cloud::VERSION
  s.authors       = ['Ryan Wong']
  s.email         = ['lazing@gmail.com']
  s.homepage      = 'https://github.com/Ryan Wong/tencent-cloud'
  s.licenses      = ['MIT']
  s.summary       = '[summary]'
  s.description   = '[description]'

  s.files         = Dir.glob('{bin/*,lib/**/*,[A-Z]*}')
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']
end
