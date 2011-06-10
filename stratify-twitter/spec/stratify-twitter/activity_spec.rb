require 'spec_helper'

describe Stratify::Twitter::Activity do
  describe "#permalink" do
    it "returns the URL for this tweet on Twitter" do
      tweet = Stratify::Twitter::Activity.new(:status_id => 20595784953102338, :username => "jasonrudolph")
      tweet.permalink.should == "http://twitter.com/jasonrudolph/status/20595784953102338"
    end
  end
end
