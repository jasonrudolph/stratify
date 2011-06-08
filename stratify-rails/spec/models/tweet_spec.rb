require 'spec_helper'

describe Tweet do
  describe "#permalink" do
    it "returns the URL for this tweet on Twitter" do
      tweet = Tweet.new(:status_id => 20595784953102338, :username => "jasonrudolph")
      tweet.permalink.should == "http://twitter.com/jasonrudolph/status/20595784953102338"
    end
  end
end
