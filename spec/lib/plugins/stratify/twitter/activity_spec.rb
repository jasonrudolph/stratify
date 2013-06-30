require 'spec_helper'

describe Stratify::Twitter::Activity do
  describe "#retweet?" do
    it "returns true when the tweet is a retweet" do
      tweet = Stratify::Twitter::Activity.new(:retweeted_status => {:status_id => 123})
      tweet.should be_retweet
    end

    it "returns false when the tweet is not a retweet" do
      tweet = Stratify::Twitter::Activity.new(:retweeted_status => nil)
      tweet.should_not be_retweet
    end
  end

  describe "#permalink" do
    it "returns the URL for this tweet on Twitter" do
      tweet = Stratify::Twitter::Activity.new(:status_id => 20595784953102338, :username => "jasonrudolph")
      tweet.permalink.should == "http://twitter.com/jasonrudolph/status/20595784953102338"
    end
  end
end
