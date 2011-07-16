require 'spec_helper'

describe "stratify-instapaper" do
  use_vcr_cassette "garmin"

  it "collects and stores data from Garmin Connect", :database => true do
    collector = Stratify::Garmin::Collector.create!(:rss_url => "http://connect.garmin.com/feed/rss/activities?feedname=Garmin%20Connect%20-%20johndoe&owner=johndoe")
    collector.run

    Stratify::Garmin::Activity.where(
      :title => "7 miles @ easy pace",
      :description => "77 degrees and sunny",
      :username => "johndoe",
      :activity_type => "Running",
      :event_type => "Uncategorized",
      :distance_in_miles => 7.0,
      :time_in_seconds => 3613,
      :elevation_gain_in_feet => 168,
      :starting_latitude => 38.0361161,
      :starting_longitude => -78.503148,
      :guid => 22222222,
      :created_at => Time.parse("Sun, 10 Jul 2011 07:50:53 EDT")
    ).should exist

    Stratify::Garmin::Activity.where(
      :guid => 33333333,
      :created_at => Time.parse("Sat, 09 Jul 2011 08:19:43 EDT")
    ).should exist
  end
end
