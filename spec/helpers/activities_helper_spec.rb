require 'spec_helper'

describe ActivitiesHelper do
  describe "determining the partial that should render an activity " do
    it "uses 'tweet' for tweets" do
      helper.partial_for_activity(Tweet.new).should == "tweet"
    end

    it "uses 'gowalla_checkin' for Gowalla checkins" do
      helper.partial_for_activity(GowallaCheckin.new).should == "gowalla_checkin"
    end

    it "uses 'instapaper_reading' for Instapaper readings" do
      helper.partial_for_activity(InstapaperReading.new).should == "instapaper_reading"
    end
    
    it "uses the underscored version of the activity's class name" do
      class SomeSampleActivity < Activity; end
      helper.partial_for_activity(SomeSampleActivity.new).should == "some_sample_activity"
    end
  end

  describe ".css_class_for_activity" do
    it "uses the downcased version of the name of the activity's source" do
      activity = stub(:source => "iTunes")
      helper.css_class_for_activity(activity).should == "itunes"
    end
  end
end
