# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'multi_bitly/version'

Gem::Specification.new do |spec|
  spec.name          = 'multi_bitly'
  spec.version       = MultiBitly::VERSION
  spec.authors       = ['Danny Olson']
  spec.email         = ['dolson@sharethrough.com']
  spec.description   = %q{Allows access to the bit.ly API with multiple accounts.}
  spec.summary       = %q{Allows access to the bit.ly API with multiple accounts.}
  spec.homepage      = 'https://github.com/sharethrough/multi_bitly'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'bitly'
  spec.add_dependency 'json', '>= 1.7.7'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.13'
end
