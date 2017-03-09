Feature: View notes
  As a guest or a user
  I want to see a list of all the notes
  so I can see if someone else already created the notes I require

Scenario: Guest views notes
  Given I'm on the home page
  And 2 notes were already created
  When I click on Notes
  Then I see 2 note rows
