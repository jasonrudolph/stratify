Feature: Manage collectors
  In order easily view, add, update, and remove collectors
  As a user
  I want to manage collectors via the UI

  Scenario: Add Gowalla collector
    Given I am on the collectors page
    When I select "Gowalla" from "Sources"
    And I press "Add collector"
    Then I should see a form for adding a new Gowalla collector
    When I fill in "Username" with "johndoe"
    And I fill in "Password" with "password"
    And I press "Save"
    Then I should be on the collectors page
    And I should see a Gowalla collector for "johndoe"

  Scenario: Add Instapaper collector
    Given I am on the collectors page
    When I select "Instapaper" from "Sources"
    And I press "Add collector"
    Then I should see a form for adding a new Instapaper collector
    When I fill in "RSS URL" with "http://www.instapaper.com/archive/rss/987654/0123456789abcdefghijklmnopq"
    And I press "Save"
    Then I should be on the collectors page
    And I should see an Instapaper collector for "http://www.instapaper.com/archive/rss/987654/0123456789abcdefghijklmnopq"

  Scenario: Add iTunes collector
    Given I am on the collectors page
    When I select "iTunes" from "Sources"
    And I press "Add collector"
    Then I should see a form for adding a new iTunes collector
    When I fill in "Location of 'iTunes Music Library.xml' file" with "/Users/jason/Music/iTunes/iTunes Music Library.xml"
    And I press "Save"
    Then I should be on the collectors page
    And I should see an iTunes collector for "/Users/jason/Music/iTunes/iTunes Music Library.xml"

  Scenario: Add Rhapsody collector
    Given I am on the collectors page
    When I select "Rhapsody" from "Sources"
    And I press "Add collector"
    Then I should see a form for adding a new Rhapsody collector
    When I fill in "RSS URL" with "http://feeds.rhapsody.com/member/ABCDEF0123456789ABCDEF0000000000/track-history.rss"
    And I press "Save"
    Then I should be on the collectors page
    And I should see an Rhapsody collector for "http://feeds.rhapsody.com/member/ABCDEF0123456789ABCDEF0000000000/track-history.rss"
    
  Scenario: Add Twitter collector
    Given I am on the collectors page
    When I select "Twitter" from "Sources"
    And I press "Add collector"
    Then I should see a form for adding a new Twitter collector
    When I fill in "Username" with "johndoe"
    And I press "Save"
    Then I should be on the collectors page
    And I should see a Twitter collector for "johndoe"
