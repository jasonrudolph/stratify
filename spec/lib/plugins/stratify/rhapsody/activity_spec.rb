require 'spec_helper'

describe Stratify::Rhapsody::Activity do
  describe "#permalink" do
    it "returns the URL of the track on Rhapsody" do
      listening = Stratify::Rhapsody::Activity.new(:track_id => "tra.1956646")
      listening.permalink.should == "http://www.rhapsody.com/goto?rcid=tra.1956646"
    end
  end
end
