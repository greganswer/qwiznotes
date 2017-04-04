Feature: View notes
  As a user
  I need to view my notes and other user notes
  So I can study for my tests

  Scenario: There are no notes yet
    Given I am on the home page
    When I click the "Notes" button
    Then I should see the "No notes found" text
    Given I am logged in
    Then I should see the "No notes found" text
    When I click the "Notes" button
    Then I should see the "No notes found" text

  Scenario: I only see my notes
    Given a note titled "Not my note" was already created
    And I am logged in
    And I created a note titled "This is my note"
    When I am on the home page
    Then I should see the "This is my note" text
    Then I should not see the "Not my note" text

  Scenario: Guest views notes
    Given I am on the home page
    Given 2 notes were already created
    When I click the "Notes" button
    Then I should see 2 notes

  Scenario: Guest views a note
    Given I am on the home page
    Given a note titled "Accounting 101 notes" was already created
    When I click on the note titled "Accounting 101 notes" in the notes list
    Then I should see the details of the note
