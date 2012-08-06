# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "stratify-github/version"

Gem::Specification.new do |s|
  s.name        = "stratify-github"
  s.version     = Stratify::GitHub::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Daemian Mack"]
  s.email       = ["daemianmack@gmail.com"]
  s.homepage    = "http://github.com/jasonrudolph/stratify/"
  s.summary     = "GitHub plugin for Stratify"
  s.description = s.summary

  s.rubyforge_project = "stratify-github"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "actionpack", "~> 3.2.0"
  s.add_runtime_dependency "railties", "~> 3.2.0"
  s.add_runtime_dependency "rinku", "~> 1.0.0"
  s.add_runtime_dependency "stratify-base", "~> 0.1.4"

  s.add_development_dependency "database_cleaner", "~> 0.7.2"
  s.add_development_dependency "fakeweb", "~> 1.3.0"
  s.add_development_dependency "rake", "~> 0.9.2"
  s.add_development_dependency "rspec", "~> 2.9.0"
  s.add_development_dependency "vcr", "~> 1.10.0"
end
