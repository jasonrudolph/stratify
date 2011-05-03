Feature: Manage iTunes history
  In order to remember what was I was watching and listening to at various times in the past
  As a reflective dude
  I want to view my iTunes history

  Scenario: Collect iTunes activity
    Given an iTunes collector is configured with the location of my iTunes library XML file
    When I run the iTunes collector
    Then my most recent iTunes music activity should exist in the archive
    And my most recent iTunes podcast activity should exist in the archive
    And my most recent iTunes TV show activity should exist in the archive
    And my most recent iTunes movie activity should exist in the archive
    And my most recent iTunes audiobook activity should exist in the archive

  Scenario: Avoid import of unplayed iTunes items
    Given an iTunes collector is configured with the location of my iTunes library XML file
    When I run the iTunes collector
    Then unplayed iTunes items should not exist in the archive

  Scenario: Avoid import of duplicate iTunes activities
    Given an iTunes collector is configured with the location of my iTunes library XML file
    When I run the iTunes collector
    And I run the iTunes collector again
    Then the archive should not include duplicate iTunes activities

  Scenario: View music activity in iTunes history
    Given I listened to "In Step" by "Girl Talk" in iTunes at 11:35 am on February 27, 2011
    When I go to the archive
    Then I should see an iTunes activity for "In Step" by "Girl Talk" at 11:35 am on February 27, 2011
