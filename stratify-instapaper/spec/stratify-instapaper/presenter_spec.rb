# encoding: utf-8

require 'spec_helper'

describe Stratify::Instapaper::Presenter do
  describe "#domain" do
    it "returns just the domain of the Instapaper item's URL" do
      activity = Stratify::Instapaper::Activity.new(:url => "http://googledocs.blogspot.com/2011/02/12-new-file-formats-in-google-docs.html")
      presenter = Stratify::Instapaper::Presenter.new(activity)
      presenter.domain.should == "googledocs.blogspot.com"
    end

    it "gracefully handles a URL containing 'unsafe' characters" do
      activity = Stratify::Instapaper::Activity.new(:url => 'http://www.heraldsun.com/view/full_story/16332513/article-Transit-tax-passes--“Great-day-for-Durham-”-Bell-says?instance=main_article')
      presenter = Stratify::Instapaper::Presenter.new(activity)
      presenter.domain.should == "www.heraldsun.com"
    end
  end

  describe "summary" do
    it "returns the Instapaper item's title when a title is present" do
      activity = Stratify::Instapaper::Activity.new(:title => "some title")
      presenter = Stratify::Instapaper::Presenter.new(activity)
      presenter.summary.should == "some title"
    end

    it "returns the Instapaper item's URL when the item does not have a title" do
      activity = Stratify::Instapaper::Activity.new(:title => "", :url => "http://example.com")
      presenter = Stratify::Instapaper::Presenter.new(activity)
      presenter.summary.should == "http://example.com"
    end
  end

  describe "details" do
    it "provides the Instapaper item's domain and description" do
      activity = Stratify::Instapaper::Activity.new(:url => "http://nex-3.com/posts/104-haml-and-sass-3-1-are-released",
                                       :description => "dhh: Great new stuff for Sass 3.1")
      presenter = Stratify::Instapaper::Presenter.new(activity)
      presenter.details.should == "nex-3.com \u2022 dhh: Great new stuff for Sass 3.1"
    end

    it "provides only the Instapaper item's domain when the description is blank" do
      activity = Stratify::Instapaper::Activity.new(:url => "http://nex-3.com/posts/104-haml-and-sass-3-1-are-released",
                                       :description => "")
      presenter = Stratify::Instapaper::Presenter.new(activity)
      presenter.details.should == "nex-3.com"
    end
  end
end
