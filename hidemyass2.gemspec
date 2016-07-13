# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hidemyass/version'

Gem::Specification.new do |spec|
  spec.name          = 'hidemyass2'
  spec.version       = HideMyAss::VERSION
  spec.authors       = ['Sebastián Katzer']
  spec.email         = ['katzer@appplant.de']

  spec.summary       = 'Hide My Ass! /2 fetches proxies at www.hidemyass.com.'
  spec.description   = 'Allows everyone to surf privately from anywhere.'
  spec.homepage      = 'https://github.com/appPlant/hidemyass2'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f =~ /spec/ }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.post_install_message = 'Install nokogiri for additional proxies.'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 11.1'
  spec.add_development_dependency 'nokogiri', '~> 1.6'

  spec.add_runtime_dependency 'json'
end
