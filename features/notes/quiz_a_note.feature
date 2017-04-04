Feature: Quiz a note
  As a user
  I need to take a quiz
  So I can practice for a test

  Background: A user on the home page
    Given I am on the home page

  Scenario: Guest takes a quiz from a note
    Given a note titled "Accounting 101 notes" was already created
    When I click on the note titled "Accounting 101 notes" in the notes list
    And I click the "Quiz" button
    Then I should see a quiz for the note
    When I select some answers and submit the quiz
    Then I should see the quiz results
