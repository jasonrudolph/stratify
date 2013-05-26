require 'spec_helper'

describe "stratify-twitter" do
  use_vcr_cassette "twitter"

  let(:collector) do
    Stratify::Twitter::Collector.create! :username => "jasonrudolph",
      :consumer_key => 'uqaeu0eAd0kKGUyPcfpcSQ',
      :consumer_secret => 'CHcsc0zJgxUjFBlrsRISrKamEfgOHjjzHjHJgS9kr0',
      :oauth_token => '14188383-G8UEUz2KVP0ZZj2IJZC2o6SuaIJnKPYud9JPl1aqO',
      :oauth_token_secret => 'GjryLDrcvBWfqAD9xY3FjOhTD7LKfNVlKsCRv6lMmfk'
  end

  it "collects and stores status updates from Twitter", :database => true do
    collector.run

    Stratify::Twitter::Activity.where(
      :created_at => Time.parse("2013-03-28T23:14:40Z"),
      :status_id => 317414466201473025,
      :username => "jasonrudolph",
      :text => "This tweet is false.",
      :retweeted_status => nil
    ).should exist
  end

  it "collects and stores retweets from Twitter", :database => true do
    collector.run

    activity = Stratify::Twitter::Activity.where(
      "created_at" => Time.parse("2013-04-18T21:24:39Z"),
      "status_id" => 324996922605711361,
      "username" => "jasonrudolph",
      "text" => "RT @github: Get up to speed with Pulse - https://t.co/yhqlLpcuv4",
      "retweeted_status.status_id" => 324996855584940033,
      "retweeted_status.username" => "github",
      "retweeted_status.text" => "Get up to speed with Pulse - https://t.co/yhqlLpcuv4"
    ).should exist
  end
end
