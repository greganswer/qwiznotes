Feature: Review table
  In order to study for a test
  As a user
  I need to view a review table of terms and definitions

  Background: A user on the home page
    Given I'm on the home page

  Scenario: Guest reviews a note
    Given a note titled "Accounting 101 notes" was already created
    When I click on the note titled "Accounting 101 notes" in the notes list
    And I click on the "Review" button
    Then I should see a review table for the note
