# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "kashflow_api/version"

Gem::Specification.new do |s|
  s.name        = "kashflow_api"
  s.version     = KashflowApi::VERSION
  s.authors     = ["Adam \"Arcath\" Laycock"]
  s.email       = ["gems@arcath.net"]
  s.homepage    = "http://ed-itsolutions.github.io/KashflowAPI"
  s.summary     = %q{Provides an interface for the Kashflow API}
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  # Development Dependencies
  s.add_development_dependency "rspec"
  
  # Runtime Dependencies
  s.add_runtime_dependency "savon", "~> 2.3"
  s.add_runtime_dependency "expects", "~> 0.0.3"
end
