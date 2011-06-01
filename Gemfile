source "http://rubygems.org"

gem "rake", "~> 0.8.7"
gem "bson_ext"
gem "gowalla"
gem "itunes_parser", :git => "git://github.com/phiggins/itunes_parser.git"
gem "jquery-rails"
gem "kaminari"
gem "mongoid"
gem "mongoid_rails_migrations"
gem "rails"
gem "simple-rss", :git => "git://github.com/jasonrudolph/simple-rss.git"
gem "tilt"
gem "twitter"
gem 'whenever', :require => false

group "development", "test" do
  gem "factory_girl_rails", :require => nil
  gem "faker"
  gem "rspec-rails"
end

group "test" do
  gem "capybara", "~> 1.0.0.beta1"
  gem "cucumber-rails"
  gem "database_cleaner"
  gem "fakeweb"
  gem "growl" # for Guard notifications
  gem "guard-cucumber"
  gem "guard-rspec"
  gem "guard-spork"
  gem "launchy"
  gem "mocha"
  gem "rb-fsevent", :require => false if RUBY_PLATFORM =~ /darwin/i
  gem "spork"
  gem "test-unit"
  gem "vcr"
end

# Deploy with Capistrano
gem 'capistrano'
