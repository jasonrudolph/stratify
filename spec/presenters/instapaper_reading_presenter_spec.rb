require 'spec_helper'

describe InstapaperReadingPresenter do
  describe "#domain" do
    it "returns just the domain of the Instapaper item's URL" do
      activity = InstapaperReading.new(:url => "http://googledocs.blogspot.com/2011/02/12-new-file-formats-in-google-docs.html")
      presenter = InstapaperReadingPresenter.new(activity)
      presenter.domain.should == "googledocs.blogspot.com"
    end
  end

  describe "summary" do
    it "returns the Instapaper item's title when a title is present" do
      activity = InstapaperReading.new(:title => "some title")
      presenter = InstapaperReadingPresenter.new(activity)
      presenter.summary.should == "some title"
    end

    it "returns the Instapaper item's URL when the item does not have a title" do
      activity = InstapaperReading.new(:title => "", :url => "http://example.com")
      presenter = InstapaperReadingPresenter.new(activity)
      presenter.summary.should == "http://example.com"
    end
  end

  describe "details" do
    it "provides the Instapaper item's domain and description" do
      activity = InstapaperReading.new(:url => "http://nex-3.com/posts/104-haml-and-sass-3-1-are-released", 
                                       :description => "dhh: Great new stuff for Sass 3.1")
      presenter = InstapaperReadingPresenter.new(activity)
      presenter.details.should == "nex-3.com \u2022 dhh: Great new stuff for Sass 3.1"
    end

    it "provides only the Instapaper item's domain when the description is blank" do
      activity = InstapaperReading.new(:url => "http://nex-3.com/posts/104-haml-and-sass-3-1-are-released", 
                                       :description => "")
      presenter = InstapaperReadingPresenter.new(activity)
      presenter.details.should == "nex-3.com"
    end
  end
end
