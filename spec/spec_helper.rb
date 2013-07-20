require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  require_relative 'prototypes/bacon'

  require 'capybara/rspec'
  require 'database_cleaner'

  RSpec.configure do |config|
    # Configure RSpec to run focused specs, and also respect the alias 'fit' for focused specs
    config.filter_run :focused => true
    config.run_all_when_everything_filtered = true
    config.alias_example_to :fit, :focused => true

    # == Mock Framework
    config.mock_with :mocha

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"

    config.extend VCR::RSpec::Macros

    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongoid"

    config.before(:each, :type => :feature) do
      DatabaseCleaner.clean
    end

    config.before(:each, :database => true) do
      DatabaseCleaner.clean
    end
  end

  def silence_stratify_logging
    # Silence the logger so as not to clutter the test output
    Stratify.stubs(:logger).returns(Logger.new("/dev/null"))
  end
end

Spork.each_run do
  Dir["#{Rails.root}/lib/**/*.rb"].each { |f| load f }
end

# --- Instructions ---
# Sort the contents of this file into a Spork.prefork and a Spork.each_run
# block.
#
# The Spork.prefork block is run only once when the spork server is started.
# You typically want to place most of your (slow) initializer code in here, in
# particular, require'ing any 3rd-party gems that you don't normally modify
# during development.
#
# The Spork.each_run block is run each time you run your specs.  In case you
# need to load files that tend to change during development, require them here.
# With Rails, your application modules are loaded automatically, so sometimes
# this block can remain empty.
#
# Note: You can modify files loaded *from* the Spork.each_run block without
# restarting the spork server.  However, this file itself will not be reloaded,
# so if you change any of the code inside the each_run block, you still need to
# restart the server.  In general, if you have non-trivial code in this file,
# it's advisable to move it into a separate file so you can easily edit it
# without restarting spork.  (For example, with RSpec, you could move
# non-trivial code into a file spec/support/my_helper.rb, making sure that the
# spec/support/* files are require'd from inside the each_run block.)
#
# Any code that is left outside the two blocks will be run during preforking
# *and* during each_run -- that's probably not what you want.
#
# These instructions should self-destruct in 10 seconds.  If they don't, feel
# free to delete them.
