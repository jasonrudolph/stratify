def xpath_permalink_selector_for(activity)
  ".//a[@href='#{activity.permalink}']"
end

Given /^the archive includes an activity$/ do
  @activity = Factory(:tweet)
end

Given /^(a|the) data collector runs( again)?$/ do |*args|
  Given 'a Twitter collector is configured for username "jasonrudolph"'
  When 'I run the Twitter collector'
end

Given /^a data collector imports an activity$/ do
  Given 'a data collector runs'
  @activity = Tweet.desc(:created_at).first
end

When /^I delete the activity$/ do
  within("article##{ActionController::RecordIdentifier.dom_id(@activity)}") do
    click_link("Delete")
  end
end

Then /^I should see the activity$/ do
  page.should have_xpath(xpath_permalink_selector_for(@activity))
end

Then /^I should (no longer|still not) see the activity$/ do |args|
  page.should_not have_xpath(xpath_permalink_selector_for(@activity))
end

Then /^it should exist in the database in a soft\-deleted fashion$/ do
  Activity.deleted.find(@activity.id).should_not be_nil
end
