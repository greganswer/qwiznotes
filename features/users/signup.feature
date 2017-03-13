Feature: Sign up
  As a user
  In order to access additional content
  I need to sign up for an account

  Background: A guest with an account
    And I'm on the home page
    And I click the "Sign up" button

  @javascript
  Scenario: Valid input
    When I fill out the sign up form correctly
    Then I should see that I signed up successfully
    And I should receive a confirmation email and be able to confirm my account
