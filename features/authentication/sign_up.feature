Feature: Sign up
  As a user
  In order to access additional content
  I need to sign up for an account

  Background: I am a guest
    And I am on the home page
    And I click the "Sign up" button

  @javascript
  Scenario: I enter valid input
    When I fill out the sign up form correctly
    Then I should see that I signed up successfully
    And I should receive a confirmation email and be able to confirm my account

  Scenario: I enter the wrong credentials
    When I leave the email address blank
    Then I should see that I am not signed up
    When I leave the password blank
    Then I should see that I am not signed up
