require 'spec_helper'

describe "stratify-twitter" do
  use_vcr_cassette "twitter"

  it "collects and stores status updates from Twitter", :database => true do
    collector = Stratify::Twitter::Collector.create!(:username => "jasonrudolph")
    collector.run

    Stratify::Twitter::Activity.where(
      :created_at => Time.parse("2011-06-08T16:22:40Z"),
      :status_id => 78497177902657536,
      :username => "jasonrudolph",
      :text => "Google finds it economically infeasible to support IE 6 & 7. You have less money than Google. Apply transitive law here. http://t.co/3lWZA2O",
      :retweeted_status => nil
    ).should exist
  end

  it "collects and stores retweets from Twitter", :database => true do
    collector = Stratify::Twitter::Collector.create!(:username => "jasonrudolph")
    collector.run

    activity = Stratify::Twitter::Activity.where(
      "created_at" => Time.parse("2011-06-21T02:10:44Z"),
      "status_id" => 82993823143297024,
      "username" => "jasonrudolph",
      "text" => %Q{RT @timoreilly: Love it: @edd in email: "Programmers don't aspire to a BMW, they aspire to write a clojure program that other people won ...},
      "retweeted_status.status_id" => 82942860218994688,
      "retweeted_status.username" => "timoreilly",
      "retweeted_status.text" => %Q{Love it: @edd in email: "Programmers don't aspire to a BMW, they aspire to write a clojure program that other people won't laugh at"},
    ).should exist
  end
end
