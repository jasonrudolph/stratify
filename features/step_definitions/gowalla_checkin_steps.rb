Given /^a Gowalla data collector is configured for username "([^"]*)" with password "([^"]*)"$/ do |username, password|
  @gowalla_collector = GowallaCollector.new(username, password)
end

Given /^I checked in on Gowalla at "([^"]*)" in "([^"]*)" at (\d+:\d+ [a|p]m) on (\w* \d+, \d+)$/ do |spot_name, spot_city_state, time, date|
  timestamp = DateTime.parse "#{date} #{time}"
  Factory(:gowalla_checkin, 
    :spot_name => spot_name, 
    :spot_city_state => spot_city_state,
    :created_at => timestamp
  )
end

When /^the Gowalla data collector runs( again)?$/ do |args|
  VCR.use_cassette('jasonrudolph') do
    @gowalla_collector.run
  end
end

Then /^I should see a Gowalla event saying "([^"]*)" at (\d+:\d+ [a|p]m) on (\w* \d+, \d+)$/ do |checkin_summary, time, date|
  within(:css, ".days li") do
    page.should have_css('p.date', :text => date)
    within(:css, "article.gowalla") do
      page.should have_css('.data-time', :text => time)
      page.should have_css('.data-content', :text => checkin_summary)
    end
  end
end

Then /^the most recent checkins from "jasonrudolph" should exist in the archive$/ do
  # The following assertions assume use of the VCR gowalla fixture

  checkin = GowallaCheckin.where(:checkin_id => 27148218).first
  checkin.should_not be_nil
  checkin.spot_name.should == 'Caribou Coffee'
  checkin.spot_city_state.should == 'Raleigh, NC'

  checkin = GowallaCheckin.where(:checkin_id => 26999668).first
  checkin.should_not be_nil
  checkin.spot_name.should == 'Starbucks'
end

Then /^the archive should not include duplicate checkins$/ do
  grouped_checkins = GowallaCheckin.only(:checkin_id).aggregate # => [{"checkin_id"=>26117880, "count"=>1.0}, {"checkin_id"=>26084701, "count"=>1.0}, ...]
  grouped_checkins.all? { |checkin| checkin["count"] == 1 }.should be_true
end
