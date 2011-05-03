Given /^a Twitter collector is configured for username "([^"]*)"$/ do |username|
  @collector = TwitterCollector.find_or_create_by(:username => username)
end

Given /^I tweeted "([^"]*)" at (\d+:\d+ [a|p]m) on (\w* \d+, \d+)$/ do |text, time, date|
  timestamp = DateTime.parse "#{date} #{time}"
  Factory(:tweet, :text => text, :created_at => timestamp)
end

Then /^I should see a tweet saying "([^"]*)" at (\d+:\d+ [a|p]m) on (\w* \d+, \d+)$/ do |text, time, date|
  within(:css, ".days li") do
    page.should have_css('p.date', :text => date)
    within(:css, "article.twitter") do
      page.should have_css('.data-time', :text => time)
      page.should have_css('.data-content', :text => text)
    end
  end
end

Then /^the most recent tweets from "jasonrudolph" should exist in the archive$/ do
  # The following assertions assume use of the "twitter_cassette" VCR fixture
  
  tweet = Tweet.where(:status_id => 28832200464011265, :username => "jasonrudolph").first
  tweet.should_not be_nil
  tweet.text.should == %Q{"I'm afraid for the state of the nation. ... I wouldn't hire you to sweep my floors." @dhh tells it like it is. http://t.co/8Wk7j8C #hiring}

  tweet = Tweet.where(:status_id => 20595784953102338, :username => "jasonrudolph").first
  tweet.should_not be_nil
  tweet.text.should == %Q{"Live as though it were the early days of a better nation." -- @doctorow}
end

Then /^the archive should not include duplicate tweets$/ do
  grouped_tweets = Tweet.only(:status_id).aggregate # => [{"status_id"=>26294541628, "count"=>1.0}, {"status_id"=>25131346543, "count"=>1.0}, ...]
  grouped_tweets.all? { |tweet| tweet["count"] == 1 }.should be_true
end
