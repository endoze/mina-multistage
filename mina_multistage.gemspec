# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mina/multistage/version'

Gem::Specification.new do |spec|
  spec.name          = "mina-multistage"
  spec.version       = Mina::Multistage::VERSION
  spec.authors       = ["Chris"]
  spec.email         = ["Chris@WideEyeLabs.com"]
  spec.description   = %q{Adds multistage capabilities to Mina}
  spec.summary       = %q{Adds multistage capabilities to Mina}
  spec.homepage      = "http://endoze.github.io/mina-multistage/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "mina", ">= 0.2.1"
  spec.add_development_dependency "bundler", ">= 1.3.5"
  spec.add_development_dependency "rake"
end
