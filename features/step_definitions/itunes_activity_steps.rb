Given /^an iTunes collector is configured with the location of my iTunes library XML file$/ do
  path = Rails.root.join("features", "fixtures", "iTunes Music Library.xml")
  @collector = ItunesCollector.create(:library_path => path.to_s)
end

Given /^I listened to "([^"]*)" by "([^"]*)" in iTunes at (\d+:\d+ [a|p]m) on (\w* \d+, \d+)$/ do |track, artist, time, date|
  timestamp = DateTime.parse "#{date} #{time}"
  Factory(:itunes_activity, :name => track, :artist => artist, :created_at => timestamp)
end

Then /^my most recent iTunes music activity should exist in the archive$/ do
  # The following assertion assumes use of the "iTunes Music Library.xml" fixture

  ItunesActivity.where(
    :persistent_id => "83B3927542025FDC",
    :name => "Smells Like Teen Spirit", 
    :album => "Nevermind",
    :artist => "Nirvana",
    :composer => "Kurt Cobain, David Grohl, Chris Novoselic",
    :genre => "Rock",
    :track_number => 1,
    :year => 1991,
    :created_at => Time.parse("2011-02-27T21:58:34Z")
  ).should exist
end

Then /^my most recent iTunes podcast activity should exist in the archive$/ do
  # The following assertion assumes use of the "iTunes Music Library.xml" fixture

  ItunesActivity.where(
    :persistent_id => "90228FA50E9DF82D",
    :name => "Tech News Today 186: Who Are Yooodle?", 
    :album => "Tech News Today",
    :artist => "Tom Merritt, Becky Worley, Sarah Lane and Jason Howell",
    :genre => "Podcast",
    :track_number => 186,
    :year => 2011,
    :podcast => true,
    :created_at => Time.parse("2011-02-27T21:52:35Z")
  ).should exist
end

Then /^my most recent iTunes TV show activity should exist in the archive$/ do
  # The following assertion assumes use of the "iTunes Music Library.xml" fixture

  ItunesActivity.where(
    :persistent_id => "7CF760E31F789363",
    :name => "Sneak Peek", 
    :album => "Comedy Central Presents, Season 15",
    :artist => "Comedy Central Stand-Up",
    :genre => "Comedy",
    :season_number => 15,
    :track_number => 101,
    :year => 2010,
    :tv_show => true,
    :created_at => Time.parse("2011-02-27T23:24:26Z")
  ).should exist
end

Then /^my most recent iTunes movie activity should exist in the archive$/ do
  # The following assertion assumes use of the "iTunes Music Library.xml" fixture

  ItunesActivity.where(
    :persistent_id => "3B7824E068FB05A6",
    :name => "V for Vendetta", 
    :genre => "Action & Adventure",
    :movie => true,
    :created_at => Time.parse("2011-02-27T23:24:35Z")
  ).should exist
end

Then /^my most recent iTunes audiobook activity should exist in the archive$/ do
  # The following assertion assumes use of the "iTunes Music Library.xml" fixture

  ItunesActivity.where(
    :persistent_id => "DB6F370B2A647633",
    :name => "Born Standing Up: A Comic's Life (Unabridged)", 
    :artist => "Steve Martin",
    :genre => "Biography & Memoir",
    :created_at => Time.parse("2011-02-27T21:52:43Z")
  ).should exist
end

Then /^unplayed iTunes items should not exist in the archive$/ do
  ItunesActivity.where(:persistent_id => "8780A3C7A0117B2B").should_not exist
end

Then /^I should see an iTunes activity for "([^"]*)" by "([^"]*)" at (\d+:\d+ [a|p]m) on (\w* \d+, \d+)$/ do |track, artist, time, date|
  within(:css, ".day") do
    page.should have_css('header.date', :text => date)
    within(:css, "article.itunes") do
      page.should have_css('.data-time', :text => time)
      page.should have_css('.data-content', :text => track)
      page.should have_css('.data-content', :text => artist)
    end
  end
end

Then /^the archive should not include duplicate iTunes activities$/ do
  grouped_activities = ItunesActivity.only(:persistent_id, :created_at).aggregate # => [{"persistent_id"=>"DB6F370B2A647633", "created_at"=>2011-02-22 11:52:00 UTC, "count"=>1.0}, {"persistent_id"=>"DB6F370B2A647633", "created_at"=>2011-02-22 11:52:00 UTC, "count"=>1.0}, ...]
  grouped_activities.all? { |activity| activity["count"] == 1 }.should be_true
end
