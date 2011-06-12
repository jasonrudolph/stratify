require 'spec_helper'

describe Stratify::Instapaper::Activity do
  describe "#permalink" do
    it "returns the URL of the Instapaper item" do
      item = Stratify::Instapaper::Activity.new(:url => "http://google.com")
      item.permalink.should == "http://google.com"
    end
  end
end
