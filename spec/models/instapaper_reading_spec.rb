require 'spec_helper'

describe InstapaperReading do
  describe "#domain" do
    it "returns just the domain of the Instapaper item's URL" do
      reading = InstapaperReading.new(:url => "http://googledocs.blogspot.com/2011/02/12-new-file-formats-in-google-docs.html")
      reading.domain.should == "googledocs.blogspot.com"
    end
  end

  describe "#permalink" do
    it "returns the URL of the Instapaper item" do
      reading = InstapaperReading.new(:url => "http://google.com")
      reading.permalink.should == "http://google.com"
    end
  end
end
