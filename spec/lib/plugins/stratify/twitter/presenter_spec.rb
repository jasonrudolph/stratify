require 'spec_helper'

describe Stratify::Twitter::Presenter do
  describe "#text" do
    context "when the tweet is a retweet" do
      it "prepends 'RT' and the original author's @username to the beginning of a tweet" do
        activity = Stratify::Twitter::Activity.new(
          :retweeted_status => {
            "text" => "foo bar",
            "username" => "wittydude"
          }
        )
        presenter = Stratify::Twitter::Presenter.new(activity)
        presenter.text.should == 'RT @wittydude foo bar'
      end
    end

    context "when the tweet is not a retweet" do
      it "returns the tweet's text without any modifications" do
        activity = Stratify::Twitter::Activity.new(:text => "foo bar")
        presenter = Stratify::Twitter::Presenter.new(activity)
        presenter.text.should == 'foo bar'
      end
    end
  end

  describe "#to_html" do
    it "wraps a Twitter @username with a link" do
      activity = Stratify::Twitter::Activity.new(:text => "foo @jasonrudolph bar")
      presenter = Stratify::Twitter::Presenter.new(activity)
      presenter.to_html.should == 'foo <a href="http://twitter.com/jasonrudolph">@jasonrudolph</a> bar'
    end

    it "wraps each Twitter @username with a link when a tweet contains multiple @usernames" do
      activity = Stratify::Twitter::Activity.new(:text => "foo @jasonrudolph bar @thinkrelevance baz")
      presenter = Stratify::Twitter::Presenter.new(activity)
      presenter.to_html.should == 'foo <a href="http://twitter.com/jasonrudolph">@jasonrudolph</a> bar <a href="http://twitter.com/thinkrelevance">@thinkrelevance</a> baz'
    end

    it "adds a link when a tweet contains a URL" do
      activity = Stratify::Twitter::Activity.new(:text => "foo http://google.com bar")
      presenter = Stratify::Twitter::Presenter.new(activity)
      presenter.to_html.should == 'foo <a href="http://google.com">http://google.com</a> bar'
    end
  end
end
