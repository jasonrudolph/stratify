require 'spec_helper'

describe TweetPresenter do
  describe "#text" do
    it "wraps a Twitter @username with a link" do
      activity = Tweet.new(:text => "foo @jasonrudolph bar")
      presenter = TweetPresenter.new(activity)
      presenter.text.should == 'foo <a href="http://twitter.com/jasonrudolph">@jasonrudolph</a> bar'
    end

    it "wraps each Twitter @username with a link when a tweet contains multiple @usernames" do
      activity = Tweet.new(:text => "foo @jasonrudolph bar @thinkrelevance baz")
      presenter = TweetPresenter.new(activity)
      presenter.text.should == 'foo <a href="http://twitter.com/jasonrudolph">@jasonrudolph</a> bar <a href="http://twitter.com/thinkrelevance">@thinkrelevance</a> baz'
    end

    it "adds a link when a tweet contains a URL" do
      activity = Tweet.new(:text => "foo http://google.com bar")
      presenter = TweetPresenter.new(activity)
      presenter.text.should == 'foo <a href="http://google.com">http://google.com</a> bar'
    end
  end
end


