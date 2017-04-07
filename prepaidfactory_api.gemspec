# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prepaidfactory_api/version'

Gem::Specification.new do |spec|
  spec.name          = "prepaidfactory_api"
  spec.version       = PrepaidfactoryApi::VERSION
  spec.authors       = ["Sander van Rossum"]
  spec.email         = ["sander.van.rossum@cg.nl"]

  spec.summary       = "Ruby API for products from Prepaid Factory"
  spec.description   = "Ruby API for producst from Prepaid Factory"
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end
end
