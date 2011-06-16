require 'spec_helper'

describe "stratify-instpaper" do
  use_vcr_cassette "instapaper"

  it "collects and stores data from Instapaper", :database => true do
    collector = Stratify::Instapaper::Collector.create!(:rss_url => "http://www.instapaper.com/archive/rss/012345/6789abcdefghijklmnopqrstuvw")
    collector.run

    Stratify::Instapaper::Activity.where(
      :title =>  "Gowalla Begins Connecting The Dots On Travel", 
      :url => "http://techcrunch.com/2011/01/28/gowalla-travel/",
      :created_at => Time.parse("Sun, 06 Feb 2011 12:28:54 EST")
    ).should exist

    Stratify::Instapaper::Activity.where(
      :title => "A List Apart: Articles: Kick Ass Kickoff Meetings", 
      :url => "http://www.alistapart.com/articles/kick-ass-kickoff-meetings/", 
      :description => "jessmartin: Project kickoff meetings need to be well designed: http://bit.ly/duPjmZ Also: http://bit.ly/gE480U", 
      :created_at => Time.parse("Mon, 07 Feb 2011 22:51:18 EST")
    ).should exist
  end
end
