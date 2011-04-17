Feature: Manage Instapaper archive
  In order to remember what was I was reading at various times in the past
  As a reflective dude
  I want to view my past Instapaper articles

  Scenario: Collect Instapaper readings
    Given my Instapaper RSS feed URL suffix is "012345/6789abcdefghijklmnopqrstuvw"
    And an Instapaper data collector is configured with that URL
    When the Instapaper data collector runs
    Then my most recent Instapaper readings should exist in the archive

  Scenario: Avoid import of duplicate Instapaper readings
    Given my Instapaper RSS feed URL suffix is "012345/6789abcdefghijklmnopqrstuvw"
    And an Instapaper data collector is configured with that URL
    When the Instapaper data collector runs
    And the Instapaper data collector runs again
    Then the archive should not include duplicate Instapaper readings
  
  Scenario: View Instapaper readings
    Given I read "Macworld Expo 2011 Best of Show winners" via Instapaper at 5:50 am on January 29, 2011
    When I go to the archive
    Then I should see an Instapaper reading for "Macworld Expo 2011 Best of Show winners" at 5:50 am on January 29, 2011
