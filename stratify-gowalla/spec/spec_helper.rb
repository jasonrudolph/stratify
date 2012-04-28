$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'stratify-gowalla'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

require 'database_cleaner'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter = :progress

  # Configure RSpec to run focused specs, and also respect the alias 'fit' for focused specs
  config.filter_run :focused => true
  config.run_all_when_everything_filtered = true
  config.alias_example_to :fit, :focused => true

  # Configure RSpec to truncate the database before any spec tagged with ":database => true"
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.orm = "mongoid"
  config.before(:each, :database => true) do
    DatabaseCleaner.clean
  end

  config.before(:suite) do
    initialize_mongoid_configuration
  end
end

def initialize_mongoid_configuration
  mongoid_config = YAML::load_file(File.join(File.dirname(__FILE__), "mongoid.yml"))
  Mongoid.from_hash(mongoid_config)
end
