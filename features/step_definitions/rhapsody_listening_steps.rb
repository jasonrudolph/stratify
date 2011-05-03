Given /^my Rhapsody RSS URL is "([^"]*)"$/ do |url|
  @rhapsody_rss_url = url
end

Given /^a Rhapsody collector is configured with that URL$/ do
  @collector = RhapsodyCollector.create(:rss_url => @rhapsody_rss_url)
end

Given /^I listened to "([^"]*)" by "([^"]*)" on Rhapsody at (\d+:\d+ [a|p]m) on (\w* \d+, \d+)$/ do |track, artist, time, date|
  timestamp = DateTime.parse "#{date} #{time}"
  Factory(:rhapsody_listening, :track_title => track, :artist_name => artist, :created_at => timestamp)
end

Then /^my most recent Rhapsody listenings should exist in the archive$/ do
  # The following assertions assume use of the "rhapsody_cassette" VCR fixture

  RhapsodyListening.where(
    :track_id => "tra.1956653", 
    :track_title => "Drain You",
    :artist_id => "art.69299",
    :artist_name => "Nirvana", 
    :album_id => "alb.238528",
    :album_title => "Nevermind", 
    :genre => "'90s Alternative",
    :created_at => Time.parse("Tue, 22 Feb 2011 03:28:00 -0800")
  ).should exist

  RhapsodyListening.where(
    :track_id => "tra.43710797", 
    :track_title => "From A Table Away",
    :artist_id => "art.13689488",
    :artist_name => "Sunny Sweeney", 
    :album_id => "alb.43710792",
    :album_title => "Sunny Sweeney EP", 
    :genre => "Honky-Tonk",
    :created_at => Time.parse("Sat, 19 Feb 2011 05:40:00 -0800")
  ).should exist
end

Then /^I should see a Rhapsody listening for "([^"]*)" by "([^"]*)" at (\d+:\d+ [a|p]m) on (\w* \d+, \d+)$/ do |track, artist, time, date|
  within(:css, ".days li") do
    page.should have_css('p.date', :text => date)
    within(:css, "article.rhapsody") do
      page.should have_css('.data-time', :text => time)
      page.should have_css('.data-content', :text => track)
      page.should have_css('.data-content', :text => artist)
    end
  end
end

Then /^the archive should not include duplicate Rhapsody listenings$/ do
  grouped_listenings = RhapsodyListening.only(:track_id, :created_at).aggregate # => [{"track_id"=>"tra.2023754", "created_at"=>2011-02-22 11:52:00 UTC, "count"=>1.0}, {"track_id"=>"tra.1956646", "created_at"=>2011-02-22 11:52:00 UTC, "count"=>1.0}, ...]
  grouped_listenings.all? { |listening| listening["count"] == 1 }.should be_true
end
