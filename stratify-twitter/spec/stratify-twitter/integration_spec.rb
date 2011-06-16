require 'spec_helper'

describe "stratify-twitter" do
  use_vcr_cassette "twitter"

  it "collects and stores data from Twitter", :database => true do
    collector = Stratify::Twitter::Collector.create!(:username => "jasonrudolph")
    collector.run

    Stratify::Twitter::Activity.where(
      :status_id => 28832200464011265,
      :username => "jasonrudolph", 
      :text => %Q{"I'm afraid for the state of the nation. ... I wouldn't hire you to sweep my floors." @dhh tells it like it is. http://t.co/8Wk7j8C #hiring},
      :created_at => Time.parse("2011-01-22T15:11:46Z")
    ).should exist

    Stratify::Twitter::Activity.where(
      :status_id => 20595784953102338,
      :username => "jasonrudolph", 
      :text => %Q{"Live as though it were the early days of a better nation." -- @doctorow},
      :created_at => Time.parse("2010-12-30T21:43:12Z")
    ).should exist
  end
end
