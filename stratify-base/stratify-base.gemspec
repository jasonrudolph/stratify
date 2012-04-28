# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "stratify/version"

Gem::Specification.new do |s|
  s.name        = "stratify-base"
  s.version     = Stratify::Base::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jason Rudolph"]
  s.email       = ["jason@jasonrudolph.com"]
  s.homepage    = "http://github.com/jasonrudolph/stratify/"
  s.summary     = "Core collector and activity componentry for Stratify"
  s.description = "Provides the infrastructure to support the development and use of Stratify collectors and activities"

  s.rubyforge_project = "stratify-base"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "bson_ext", "~> 1.3.1"
  s.add_runtime_dependency "mongoid", "~> 2.0.2"
  s.add_runtime_dependency "tilt", "~> 1.3.2"

  s.add_development_dependency "rake", "~> 0.9.2"
  s.add_development_dependency "rspec", "~> 2.6.0"
  s.add_development_dependency "mocha", "~> 0.9.12"
  s.add_development_dependency "database_cleaner", "~> 0.7.2"
end
