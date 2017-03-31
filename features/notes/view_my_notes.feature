Feature: View notes
  As a user
  In order to plan my studying
  I need to see a list of all my notes

  Background: I'm logged in
    Given a note titled "Not my note" was already created
    And I am logged in
    And I created a note titled "This is my note"

  Scenario: I only see my notes
    Given I'm on the home page
    Then I should see the "This is my note" text
    Then I should not see the "Not my note" text
