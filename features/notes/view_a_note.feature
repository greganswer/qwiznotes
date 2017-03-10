Feature: View a note
  As a guest or a user
  I want to view another user’s note
  so I can study from it and can save time by not writing my own note

Scenario: Guest views a note
  Given I'm on the home page
  And a note titled "Accounting 101 notes" was already created
  When I click on Notes
  And I click on the "Accounting 101 notes" link
  Then I see the details of the note

