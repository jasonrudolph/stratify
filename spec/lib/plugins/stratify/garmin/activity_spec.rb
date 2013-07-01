require 'spec_helper'

describe Stratify::Garmin::Activity do
  describe "#permalink" do
    it "returns the URL for this activity on Garmin Connect" do
      activity = Stratify::Garmin::Activity.new(:guid => 12345678)
      activity.permalink.should == "http://connect.garmin.com/activity/12345678"
    end
  end
end
