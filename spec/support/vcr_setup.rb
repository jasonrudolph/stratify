require 'vcr'

VCR.config do |c|
  c.cassette_library_dir = 'vcr_cassettes'
  c.stub_with :fakeweb
  c.default_cassette_options = { :record => :once }
end
