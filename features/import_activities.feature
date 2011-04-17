Feature: Import activities
  In order to maintain an up-to-date collection of my past activities
  As a reflective dude
  I want activities automatically imported

  Scenario: Import activities for all configured data collectors
    Given the application is configured to collect Twitter data for username "jasonrudolph"
    Given the application is configured to collect Gowalla data for username "jasonrudolph" with password "secret"
    When the collection process runs
    Then the most recent tweets from "jasonrudolph" should exist in the archive
    Then the most recent checkins from "jasonrudolph" should exist in the archive
