Given /^the application is configured to collect Twitter data for username "([^"]*)"$/ do |username|
  @collector_coordinator ||= CollectorCoordinator.new
  @collector_coordinator.add TwitterCollector.new(username)
end

Given /^the application is configured to collect Gowalla data for username "([^"]*)" with password "([^"]*)"$/ do |username, password|
  @collector_coordinator ||= CollectorCoordinator.new
  @collector_coordinator.add GowallaCollector.new(username, password)
end

When /^the collection process runs$/ do
  VCR.use_cassette('jasonrudolph') do
    @collector_coordinator.run
  end
end
