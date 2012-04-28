# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "stratify-rhapsody/version"

Gem::Specification.new do |s|
  s.name        = "stratify-rhapsody"
  s.version     = Stratify::Rhapsody::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jason Rudolph"]
  s.email       = ["jason@jasonrudolph.com"]
  s.homepage    = "http://github.com/jasonrudolph/stratify/"
  s.summary     = "Rhapsody plugin for Stratify"
  s.description = s.summary

  s.rubyforge_project = "stratify-rhapsody"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "railties", "~> 3.2.0"
  s.add_runtime_dependency "stratify-base", "~> 0.1.3"
  s.add_runtime_dependency "thoughtafter-simple-rss", "~> 1.2.3"

  s.add_development_dependency "database_cleaner", "~> 0.7.2"
  s.add_development_dependency "fakeweb", "~> 1.3.0"
  s.add_development_dependency "rake", "~> 0.9.2"
  s.add_development_dependency "rspec", "~> 2.9.0"
  s.add_development_dependency "vcr", "~> 1.10.0"
end
