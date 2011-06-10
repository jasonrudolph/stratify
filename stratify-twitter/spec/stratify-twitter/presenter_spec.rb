require 'spec_helper'

describe Stratify::Twitter::Presenter do
  describe "#text" do
    it "wraps a Twitter @username with a link" do
      activity = Stratify::Twitter::Activity.new(:text => "foo @jasonrudolph bar")
      presenter = Stratify::Twitter::Presenter.new(activity)
      presenter.text.should == 'foo <a href="http://twitter.com/jasonrudolph">@jasonrudolph</a> bar'
    end

    it "wraps each Twitter @username with a link when a tweet contains multiple @usernames" do
      activity = Stratify::Twitter::Activity.new(:text => "foo @jasonrudolph bar @thinkrelevance baz")
      presenter = Stratify::Twitter::Presenter.new(activity)
      presenter.text.should == 'foo <a href="http://twitter.com/jasonrudolph">@jasonrudolph</a> bar <a href="http://twitter.com/thinkrelevance">@thinkrelevance</a> baz'
    end

    it "adds a link when a tweet contains a URL" do
      activity = Stratify::Twitter::Activity.new(:text => "foo http://google.com bar")
      presenter = Stratify::Twitter::Presenter.new(activity)
      presenter.text.should == 'foo <a href="http://google.com">http://google.com</a> bar'
    end
  end
end


