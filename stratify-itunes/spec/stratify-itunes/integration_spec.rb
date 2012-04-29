require 'spec_helper'

describe "collecting and storing iTunes data", :database => true do
  before do
    itunes_library_path = File.expand_path('../../fixtures/iTunes Music Library.xml', __FILE__)
    collector = Stratify::ITunes::Collector.create!(:library_path => itunes_library_path)
    collector.run
  end

  it "collects and stores recently-played music from iTunes" do
    Stratify::ITunes::Activity.where(
      :persistent_id => "83B3927542025FDC",
      :name => "Smells Like Teen Spirit",
      :album => "Nevermind",
      :artist => "Nirvana",
      :composer => "Kurt Cobain, David Grohl, Chris Novoselic",
      :genre => "Rock",
      :track_number => 1,
      :year => 1991,
      :created_at => Time.parse("2011-02-27T21:58:34Z")
    ).should exist
  end

  it "collects and stores recently-played podcasts from iTunes" do
    Stratify::ITunes::Activity.where(
      :persistent_id => "90228FA50E9DF82D",
      :name => "Tech News Today 186: Who Are Yooodle?",
      :album => "Tech News Today",
      :artist => "Tom Merritt, Becky Worley, Sarah Lane and Jason Howell",
      :genre => "Podcast",
      :track_number => 186,
      :year => 2011,
      :podcast => true,
      :created_at => Time.parse("2011-02-27T21:52:35Z")
    ).should exist
  end

  it "collects and stores recently-played TV shows from iTunes" do
    Stratify::ITunes::Activity.where(
      :persistent_id => "401802E7B506C475",
      :name => "A No-Rough-Stuff Type Deal",
      :album => "Breaking Bad, Season 1",
      :artist => "Breaking Bad",
      :genre => "Drama",
      :season_number => 1,
      :episode_number => 7,
      :year => 2008,
      :tv_show => true,
      :created_at => Time.parse("2010-05-31T18:52:27Z")
    ).should exist
  end

  it "collects and stores recently-played movies from iTunes" do
    Stratify::ITunes::Activity.where(
      :persistent_id => "3B7824E068FB05A6",
      :name => "V for Vendetta",
      :genre => "Action & Adventure",
      :movie => true,
      :created_at => Time.parse("2011-02-27T23:24:35Z")
    ).should exist
  end

  it "collects and stores recently-played audiobooks from iTunes" do
    Stratify::ITunes::Activity.where(
      :persistent_id => "DB6F370B2A647633",
      :name => "Born Standing Up: A Comic's Life (Unabridged)",
      :artist => "Steve Martin",
      :genre => "Biography & Memoir",
      :created_at => Time.parse("2011-02-27T21:52:43Z")
    ).should exist
  end

  it "does not collect unplayed items from iTunes" do
    Stratify::ITunes::Activity.where(:persistent_id => "8780A3C7A0117B2B").should_not exist
  end
end

describe "reading a remote iTunes library file", :database => true do
  use_vcr_cassette "itunes"

  it "works over HTTP" do
    itunes_library_path = "http://dl.dropbox.com/u/1234567/iTunes%20Music%20Library.xml"
    collector = Stratify::ITunes::Collector.create!(:library_path => itunes_library_path)
    collector.run

    Stratify::ITunes::Activity.where(:persistent_id => "83B3927542025FDC").should exist
  end
end

