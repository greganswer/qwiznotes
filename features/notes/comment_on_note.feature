Feature: Comment on note
  As a user
  I need to comment on a note
  So I can engage in a discussion about the note

  @javascript
  Scenario: I am logged in
    Given a note titled "Not my note" was already created
    And I am logged in
    And I click on the note titled "Not my note" in the notes list
    When I fill in the comment form
    Then I should see that the comment was created
