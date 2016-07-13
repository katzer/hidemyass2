$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'json'
require 'nokogiri'
require 'simplecov'
require 'webmock/rspec'
require 'codeclimate-test-reporter'
require 'pry'

WebMock.disable_net_connect!(allow: 'codeclimate.com')

CodeClimate::TestReporter.start if RUBY_ENGINE == 'ruby'

SimpleCov.start do
  add_filter '/spec'
  formatter SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      CodeClimate::TestReporter::Formatter
    ]
  )
end

Dir['lib/**/*.rb'].each { |f| require_relative "../#{f}" }
