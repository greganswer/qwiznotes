Feature: View notes
  As a user
  In order to see if someone else already created the notes I require
  I need to see a list of all the notes

  Background: A user on the home page
    Given I'm on the home page

  Scenario: There are no notes yet
    When I click the "Notes" button
    Then I should see the "No notes found" text

  Scenario: Guest views notes
    Given 2 notes were already created
    When I click the "Notes" button
    Then I should see 2 notes
