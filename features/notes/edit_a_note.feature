Feature: Edit a note
  As a user
  I need to edit my note
  So I can improve it

  Background: I am logged in
    Given a note titled "Not my note" was already created
    And I am logged in
    And I created a note titled "This is my note"
    And I am on the home page

  @javascript
  Scenario: I successfully edit my note
    When I click on the note titled "This is my note" in the notes list
    And I click on the note "Edit" button
    And I fill in the note form
    Then I should see that the note was updated

  # FIXME: Not working with TinyMCE editor
  # @javascript
  # Scenario: I do not complete the note form
  #   When I click on the note titled "This is my note" in the notes list
  #   And I click on the note "Edit" button
  #   And I do not enter the note content
  #   Then I should see that the note was not updated

  Scenario: I cannot update a note when not logged in
    When I log out
    And I click the "Notes" button
    Then I should not see the "Edit" button for any note

  Scenario: I cannot update a note that I do not own
    When I click the "Notes" button
    And I click on the note titled "Not my note" in the notes list
    Then I should not see the "Edit" button on the note titled "Not my note"
