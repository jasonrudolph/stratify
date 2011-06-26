require 'spec_helper'

describe "stratify-gowalla" do
  use_vcr_cassette "gowalla"

  it "collects and stores data from Gowalla", :database => true do
    collector = Stratify::Gowalla::Collector.create!(:username => "jasonrudolph", :password => "secret")
    collector.run

    Stratify::Gowalla::Activity.where(
      :checkin_id => 27147302,
      :spot_name => "Dick's Sporting Goods",
      :spot_city_state => "Morrisville, NC",
      :message => "Final prep for Breckenridge trip!",
      :created_at => Time.parse("2011-01-22T17:47:33Z")
    ).should exist

    Stratify::Gowalla::Activity.where(
      :checkin_id => 26999668,
      :spot_name => "Starbucks",
      :created_at => Time.parse("2011-01-20T21:35:25Z")
    ).should exist
  end
end
