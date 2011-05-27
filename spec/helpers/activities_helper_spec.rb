require 'spec_helper'

describe ActivitiesHelper do
  describe ".css_class_for_activity" do
    it "uses the downcased version of the name of the activity's source" do
      activity = stub(:source => "iTunes")
      helper.css_class_for_activity(activity).should == "itunes"
    end
  end
end
