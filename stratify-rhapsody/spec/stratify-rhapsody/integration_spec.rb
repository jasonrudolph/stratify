require 'spec_helper'

describe "stratify-rhapsody" do
  use_vcr_cassette "rhapsody"

  it "collects and stores data from Rhapsody", :database => true do
    collector = Stratify::Rhapsody::Collector.create!(:rss_url => "http://feeds.rhapsody.com/member/ABCDEFGHIJKLMNOPQRSTUVWXYZ123456/track-history.rss")
    collector.run

    Stratify::Rhapsody::Activity.where(
      :track_id => "tra.1956653", 
      :track_title => "Drain You",
      :artist_id => "art.69299",
      :artist_name => "Nirvana", 
      :album_id => "alb.238528",
      :album_title => "Nevermind", 
      :genre => "'90s Alternative",
      :created_at => Time.parse("Tue, 22 Feb 2011 03:28:00 -0800")
    ).should exist

    Stratify::Rhapsody::Activity.where(
      :track_id => "tra.43710797", 
      :track_title => "From A Table Away",
      :artist_id => "art.13689488",
      :artist_name => "Sunny Sweeney", 
      :album_id => "alb.43710792",
      :album_title => "Sunny Sweeney EP", 
      :genre => "Honky-Tonk",
      :created_at => Time.parse("Sat, 19 Feb 2011 05:40:00 -0800")
    ).should exist
  end
end
