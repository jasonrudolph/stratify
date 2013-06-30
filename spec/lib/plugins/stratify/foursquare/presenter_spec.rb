require 'spec_helper'

describe Stratify::Foursquare::Presenter do
  describe "summary" do
    it "includes the venue name, city, and state" do
      activity = Stratify::Foursquare::Activity.new(
        :venue_name => "Cochon",
        :venue_city => "New Orleans",
        :venue_state => "LA",
      )
      presenter = Stratify::Foursquare::Presenter.new(activity)
      presenter.summary.should == "Checked in at <strong>Cochon</strong> in <strong>New Orleans, LA</strong>"
    end

    it "includes the venue name and city when the state is blank" do
      activity = Stratify::Foursquare::Activity.new(
        :venue_name => "Cochon",
        :venue_city => "New Orleans",
        :venue_state => nil,
      )
      presenter = Stratify::Foursquare::Presenter.new(activity)
      presenter.summary.should == "Checked in at <strong>Cochon</strong> in <strong>New Orleans</strong>"
    end

    it "includes the venue name and state when the city is blank" do
      activity = Stratify::Foursquare::Activity.new(
        :venue_id => "4b4a2b6ff964a520307d26e3", # real venue with no city or country info
        :venue_name => "Hilton Papagayo Costa Rica Resort",
        :venue_city => nil,
        :venue_state => "Guanacaste",
      )
      presenter = Stratify::Foursquare::Presenter.new(activity)
      presenter.summary.should == "Checked in at <strong>Hilton Papagayo Costa Rica Resort</strong> in <strong>Guanacaste</strong>"
    end

    it "includes only the venue name when the venue has no location data" do
      activity = Stratify::Foursquare::Activity.new(
        :venue_name => "Cochon",
        :venue_city => nil,
        :venue_state => nil,
      )
      presenter = Stratify::Foursquare::Presenter.new(activity)
      presenter.summary.should == "Checked in at <strong>Cochon</strong>"
    end
  end
end
