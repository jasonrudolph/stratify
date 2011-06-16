$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'stratify-base'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

require 'database_cleaner'

require 'prototypes/bacon'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter = :progress
  config.mock_with :mocha

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
    silence_mongoid_logging
    initialize_mongoid_configuration
  end
end

def silence_mongoid_logging
  Mongoid.logger = Logger.new("/dev/null")
end

def silence_stratify_logging
  Stratify.stubs(:logger).returns(Logger.new("/dev/null")) # Silence the logger so as not to clutter the test output
end

def initialize_mongoid_configuration
  mongoid_config = YAML::load_file(File.join(File.dirname(__FILE__), "mongoid.yml"))
  Mongoid.from_hash(mongoid_config)
end