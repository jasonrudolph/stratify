source "http://rubygems.org"

# Default Rails dependencies
gem "rails", "3.2.13"
gem "jquery-rails"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier',     "~> 1.0.3"
end

# Used by core collector/activity code (in lib/stratify)
gem "bson_ext", "~> 1.6.0"
gem "mongoid",  "~> 2.4.0"
gem "tilt",     "~> 1.4.1"

# Used by various collectors
gem "foursquare2",             "~> 1.9.7"
gem "itunes-library",          "~> 0.1.1"
gem "nokogiri",                "~> 1.4.4"
gem "rinku",                   "~> 1.0.0"
gem "thoughtafter-simple-rss", "~> 1.2.3"
gem "twitter",                 "~> 4.8.1"

# Used by Rails app
gem "kaminari",                 "~> 0.14.1"
gem "mongoid_rails_migrations", "~> 0.0.14"
gem 'whenever',                 "~> 0.8.3", :require => false
gem 'capistrano',               "~> 2.15.5" # for deployment

group "development", "test" do
  gem "factory_girl_rails", "~> 4.2.1"
  gem "faker",              "~> 1.1.2"
  gem "rspec-rails",        "~> 2.0"
end

group "test" do
  gem "capybara",         "~> 2.1.0"
  gem "database_cleaner", "~> 1.0.1"
  gem "fakeweb",          "~> 1.3.0"
  gem "guard-rspec",      "~> 3.0.2"
  gem "guard-spork",      "~> 1.0.1"
  gem "launchy",          "~> 2.3.0"
  gem "mocha",            "~> 0.14.0", :require => false
  gem "rb-fsevent",       "~> 0.9.3", :require => false if RUBY_PLATFORM =~ /darwin/i
  gem "spork",            "~> 0.9.2"
  gem "vcr",              "~> 1.10.0"
end
