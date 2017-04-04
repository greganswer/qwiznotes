Feature: Review table
  As a user
  I need to view a review table of terms and definitions
  So I can study for a test

  Background: A user on the home page
    Given I am on the home page

  Scenario: Guest reviews a note
    Given a note titled "Accounting 101 notes" was already created
    When I click on the note titled "Accounting 101 notes" in the notes list
    And I click on the "Review" button
    Then I should see a review table for the note
