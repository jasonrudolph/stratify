Feature: Manage Gowalla checkins
  In order to remember where I was (and what I was doing) at various times in the past
  As a reflective dude
  I want to view my past Gowalla checkins

  @gowalla_cassette
  Scenario: Collect Gowalla checkins
    Given a Gowalla data collector is configured for username "jasonrudolph" with password "secret"
    When the Gowalla data collector runs
    Then the most recent checkins from "jasonrudolph" should exist in the archive

  @gowalla_cassette
  Scenario: Avoid import of duplicate Gowalla checkins
    Given a Gowalla data collector is configured for username "jasonrudolph" with password "secret"
    When the Gowalla data collector runs
    And the Gowalla data collector runs again
    Then the archive should not include duplicate checkins

  Scenario: View Gowalla checkins
    Given I checked in on Gowalla at "Fresh" in "Raleigh, NC" at 7:43 pm on November 24, 2010
    When I go to the archive
    Then I should see a Gowalla event saying "Checked in at Fresh in Raleigh, NC" at 7:43 pm on November 24, 2010
