Feature: Create a note
  As a user
  I need to create a note
  So I can use the note features of the site

  Background: I am logged in
    Given I am logged in
    And I click the "New Note" button

  @javascript
  Scenario: I successfully create a note
    When I fill in the note form
    Then I should see that the note was created

  @javascript
  Scenario: Some fields have default values
    When I do not enter the note title
    Then I should see that the note was created

  @javascript
  Scenario: I do not complete the note form
    When I do not enter the note content
    Then I should see that the note was not created

  Scenario: I cannot create a note when not logged in
     When I log out
     Then I should not see the "New Note" button
