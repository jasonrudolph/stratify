Given /^my Instapaper RSS URL is "([^"]*)"$/ do |url|
  @instapaper_rss_url = url
end

Given /^an Instapaper data collector is configured with that URL$/ do
  @instapaper_collector = InstapaperCollector.new(:rss_url => @instapaper_rss_url)
end

Given /^I read "([^"]*)" via Instapaper at (\d+:\d+ [a|p]m) on (\w* \d+, \d+)$/ do |title, time, date|
  timestamp = DateTime.parse "#{date} #{time}"
  Factory(:instapaper_reading, :title => title, :created_at => timestamp)
end

When /^the Instapaper data collector runs( again)?$/ do |args|
  VCR.use_cassette('instapaper') do
    @instapaper_collector.run
  end
end

Then /^my most recent Instapaper readings should exist in the archive$/ do
  # The following assertions assume use of the VCR "instapaper" fixture

  InstapaperReading.where(
    :title =>  "Gowalla Begins Connecting The Dots On Travel", 
    :url => "http://techcrunch.com/2011/01/28/gowalla-travel/",
  ).should exist

  InstapaperReading.where(
    :title => "A List Apart: Articles: Kick Ass Kickoff Meetings", 
    :url => "http://www.alistapart.com/articles/kick-ass-kickoff-meetings/", 
    :description => "jessmartin: Project kickoff meetings need to be well designed: http://bit.ly/duPjmZ Also: http://bit.ly/gE480U", 
    :created_at => Time.parse("Mon, 07 Feb 2011 22:51:18 EST")
  ).should exist
end

Then /^I should see an Instapaper reading for "([^"]*)" at (\d+:\d+ [a|p]m) on (\w* \d+, \d+)$/ do |title, time, date|
  within(:css, ".days li") do
    page.should have_css('p.date', :text => date)
    within(:css, "article.instapaper") do
      page.should have_css('.data-time', :text => time)
      page.should have_css('.data-content', :text => title)
    end
  end
end

Then /^the archive should not include duplicate Instapaper readings$/ do
  grouped_readings = InstapaperReading.only(:url, :created_at).aggregate # => [{"url"=>"http://techcrunch.com/2011/01/28/gowalla-travel/", "created_at"=>2011-02-22 02:57:27 UTC, "count"=>1.0}, {"url"=>"http://www.alistapart.com/articles/kick-ass-kickoff-meetings/", "created_at"=>2011-02-21 04:19:46 UTC, "count"=>1.0}, ...]
  grouped_readings.all? { |reading| reading["count"] == 1 }.should be_true
end
