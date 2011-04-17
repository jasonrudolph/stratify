require 'vcr'

VCR.config do |c|
  c.stub_with :fakeweb
  c.cassette_library_dir = 'features/fixtures/cassette_library'
  c.ignore_localhost = true
  c.default_cassette_options = { :record => :none }
end