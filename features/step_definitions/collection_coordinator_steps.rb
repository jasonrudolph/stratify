Given /^the application is configured to collect Twitter data for username "([^"]*)"$/ do |username|
  TwitterCollector.create!(:username => username)
end

Given /^the application is configured to collect Gowalla data for username "([^"]*)" with password "([^"]*)"$/ do |username, password|
  GowallaCollector.create!(:username => username, :password => password)
end

When /^the collection process runs$/ do
  VCR.use_cassette('jasonrudolph') do
    CollectorCoordinator.run_all
  end
end
