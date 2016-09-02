# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scalar/version'

Gem::Specification.new do |spec|
  spec.name          = "scalar"
  spec.version       = Scalar::VERSION
  spec.authors       = ["Kelly Stannard"]
  spec.email         = ["kwstannard@gmail.com"]

  spec.summary       = %q{Thin and performant measurement library}
  spec.description   = %q{Thin and performant measurement library}
  spec.homepage      = "https://github.com/CasperSleep/scalar"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = Dir["lib/**/*"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec", "~> 3.0"
end
