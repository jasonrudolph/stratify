Feature: Manage activities
  In order to remember what I was up to at various times in the past
  As a reflective dude
  I want to view my past activities

  Scenario: Soft delete an activity
    Given the archive includes an activity
    When I go to the archive
    Then I should see the activity
    When I delete the activity
    Then I should no longer see the activity
    But it should exist in the database in a soft-deleted fashion

  Scenario: Soft deleted activities do not get re-imported
    Given a data collector imports an activity
    When I go to the archive
    And I delete the activity
    Then I should no longer see the activity
    When the data collector runs again
    And I go to the archive
    Then I should still not see the activity
