Feature: Manage Rhapsody listening history
  In order to remember what was I was listening to at various times in the past
  As a reflective dude
  I want to view my Rhapsody listening history

  Scenario: Collect Rhapsody listenings
    Given my Rhapsody RSS feed member ID is "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456"
    And a Rhapsody data collector is configured with that member ID
    When the Rhapsody data collector runs
    Then my most recent Rhapsody listenings should exist in the archive

  Scenario: Avoid import of duplicate Rhapsody listenings
    Given my Rhapsody RSS feed member ID is "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456"
    And a Rhapsody data collector is configured with that member ID
    When the Rhapsody data collector runs
    And the Rhapsody data collector runs again
    Then the archive should not include duplicate Rhapsody listenings

  Scenario: View Rhapsody listening history
    Given I listened to "Kanye West vs. Darwish" by "Aziz Ansari" on Rhapsody at 7:23 pm on February 12, 2011
    When I go to the archive
    Then I should see a Rhapsody listening for "Kanye West vs. Darwish" by "Aziz Ansari" at 7:23 pm on February 12, 2011
