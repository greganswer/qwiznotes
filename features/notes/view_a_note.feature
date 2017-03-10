Feature: View a note
  As a user
  In order to save time and not write my own note
  I need to view another user’s note

  Background: A user on the home page
    Given I'm on the home page

  Scenario: Guest views a note
    Given a note titled "Accounting 101 notes" was already created
    When I click on the note titled "Accounting 101 notes" in the notes list
    Then I should see the details of the note
