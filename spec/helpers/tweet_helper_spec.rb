require 'spec_helper'

describe TweetHelper do
  describe ".auto_link_tweet_text" do
    it "adds a link when a tweet contains a @username" do
      result = helper.auto_link_tweet_text("foo @jasonrudolph bar")
      result.should == 'foo <a href="http://twitter.com/jasonrudolph">@jasonrudolph</a> bar'
    end

    it "adds multiple links when a tweet contains multiple @usernames" do
      result = helper.auto_link_tweet_text("foo @jasonrudolph bar @thinkrelevance baz")
      result.should == 'foo <a href="http://twitter.com/jasonrudolph">@jasonrudolph</a> bar <a href="http://twitter.com/thinkrelevance">@thinkrelevance</a> baz'
    end

    it "adds a link when a tweet contains a URL" do
      result = helper.auto_link_tweet_text("foo http://google.com bar")
      result.should == 'foo <a href="http://google.com">http://google.com</a> bar'
    end
  end
end
