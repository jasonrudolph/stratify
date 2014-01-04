source 'http://rubygems.org'

# Default Rails dependencies
gem 'rails',        '4.0.2'
gem 'sass-rails',   '~> 4.0.0'
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'capistrano',   '~> 2.15.5', :group => :development

# Used by core collector/activity code (in lib/stratify)
gem 'mongoid',          :github => 'mongoid/mongoid'
gem 'mongoid-paranoia', :github => 'simi/mongoid-paranoia'
gem 'tilt',             '~> 1.4.1'

# Used by various collectors
gem 'foursquare2',             '~> 1.9.7'
gem 'itunes-library',          '~> 0.1.1'
gem 'nokogiri',                '~> 1.6.0'
gem 'rinku',                   '~> 1.7.3'
gem 'thoughtafter-simple-rss', '~> 1.2.3'
gem 'twitter',                 '~> 4.8.1'

# Used by Rails app
gem 'kaminari',                 '~> 0.14.1'
gem 'mongoid_rails_migrations', '~> 1.0.1'
gem 'whenever',                 '~> 0.8.3', :require => false

group 'development', 'test' do
  gem 'factory_girl_rails', '~> 4.2.1'
  gem 'faker',              '~> 1.1.2'
  gem 'pry',                '~> 0.9.12'
  gem 'rspec-rails',        '~> 2.14'
end

group 'test' do
  gem 'capybara',         '~> 2.1.0'
  gem 'database_cleaner', '~> 1.0.1'
  gem 'fakeweb',          '~> 1.3.0'
  gem 'guard-rspec',      '~> 3.0.2'
  gem 'guard-spork',      '~> 1.5.1'
  gem 'launchy',          '~> 2.3.0'
  gem 'mocha',            '~> 0.14.0', :require => false
  gem 'rb-fsevent',       '~> 0.9.3', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'spork-rails',      :github => 'sporkrb/spork-rails'
  gem 'vcr',              '~> 1.10.0'
end
