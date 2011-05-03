Feature: Manage tweets
  In order to remember what was on my mind at various times in the past
  As a reflective dude
  I want to view my past tweets

  @twitter_cassette
  Scenario: Collect tweets
    Given a Twitter collector is configured for username "jasonrudolph"
    When I run the Twitter collector
    Then the most recent tweets from "jasonrudolph" should exist in the archive

  @twitter_cassette
  Scenario: Avoid import of duplicate Twitter posts
    Given a Twitter collector is configured for username "jasonrudolph"
    When I run the Twitter collector
    And I run the Twitter collector again
    Then the archive should not include duplicate tweets

  Scenario: View tweets
    Given I tweeted "Mmmm. Sugar Cookie Egg Nog." at 2:50 pm on November 27, 2010
    When I go to the archive
    Then I should see a tweet saying "Mmmm. Sugar Cookie Egg Nog." at 2:50 pm on November 27, 2010
