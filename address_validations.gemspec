$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require 'address.rb'
require 'valid_addr.rb'

# TODO: Below, change the gem name, authors, and email

Gem::Specification.new do |s|
  s.name        = 'address_validations'
  s.version     = '0.9'
  s.date        = '2013-03-14'
  s.summary     = "address validation"
  s.description = "A library for address validation and manipulation"
  s.authors     = ["Andy Reilly"]
  s.email       = '1vw2go@gmail.com'
  s.homepage    = 'http://rubygems.org/gems/address_validations'
  s.files       = ["lib/address.rb", "lib/valid_addr.rb"]
end