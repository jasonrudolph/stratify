# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "stratify-itunes/version"

Gem::Specification.new do |s|
  s.name        = "stratify-itunes"
  s.version     = Stratify::ITunes::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jason Rudolph"]
  s.email       = ["jason@jasonrudolph.com"]
  s.homepage    = "http://github.com/jasonrudolph/stratify/"
  s.summary     = "iTunes plugin for Stratify"
  s.description = s.summary

  s.rubyforge_project = "stratify-itunes"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "railties", "~> 3.1.0.rc1"
  s.add_runtime_dependency "stratify-base", "~> 0.1.0"
  s.add_runtime_dependency "itunes-library", "~> 0.1.1"

  s.add_development_dependency "database_cleaner", "~> 0.6.7"
  s.add_development_dependency "rspec", "~> 2.6.0"
end
