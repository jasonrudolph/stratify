require 'vcr'

VCR.config do |c|
  c.stub_with :fakeweb
  c.cassette_library_dir = 'features/fixtures/cassette_library'
  c.ignore_localhost = true
  c.default_cassette_options = { :record => :none }
end

VCR.cucumber_tags do |t|
  t.tags '@gowalla_cassette', '@instapaper_cassette', '@rhapsody_cassette', '@twitter_cassette'
end