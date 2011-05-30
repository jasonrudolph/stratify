require 'spec_helper'

describe InstapaperReading do
  describe "#permalink" do
    it "returns the URL of the Instapaper item" do
      reading = InstapaperReading.new(:url => "http://google.com")
      reading.permalink.should == "http://google.com"
    end
  end
end
