require 'spec_helper'

describe Stratify::Garmin::Presenter do
  describe "summary" do
    it "provides the activity's type and title" do
      activity = Stratify::Garmin::Activity.new(:title => "4x800 intervals", :activity_type => "Running")
      presenter = Stratify::Garmin::Presenter.new(activity)
      presenter.summary.should == "Running: 4x800 intervals"
    end
  end

  describe "details" do
    it "provides the activity's distance, time, and description" do
      activity = Stratify::Garmin::Activity.new(
        :distance_in_miles => 7,
        :time_in_seconds => 3613,
        :description => "77 degrees and sunny"
      )
      presenter = Stratify::Garmin::Presenter.new(activity)
      presenter.details.should == "7.00 miles \u2022 60 minutes, 13 seconds \u2022 77 degrees and sunny"
    end

    it "provides only the activity's distance and time when the description is blank" do
      activity = Stratify::Garmin::Activity.new(
        :distance_in_miles => 7,
        :time_in_seconds => 3613,
        :description => ""
      )
      presenter = Stratify::Garmin::Presenter.new(activity)
      presenter.details.should == "7.00 miles \u2022 60 minutes, 13 seconds"
    end
  end
end
